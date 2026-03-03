# Vérification Active Storage – Eventbrite THP

**Date :** 2025-03-03

## 1. Structure du dossier `storage/`

```
storage/
├── .keep
└── w3/
    └── rd/     ← vide (aucun fichier)
```

- Le dossier `storage/` existe et contient `.keep`
- La sous-arborescence `w3/rd/` a été créée (structure Active Storage classique)
- **Problème :** le dossier `w3/rd/` est vide, aucun fichier binaire n’y est stocké

## 2. Diagnostic

### Causes possibles

1. **Blobs sans fichier sur disque**
   - Enregistrements dans `active_storage_blobs` et `active_storage_attachments`
   - Fichiers manquants dans `storage/` (supprimés ou jamais écrits)

2. **Environnement Rails non disponible**
   - `bundle install` n’a pas été exécuté ou les gems ne sont pas installées
   - Impossible d’exécuter `rails runner` pour vérifier la base

3. **Base de données**
   - Accès à PostgreSQL non vérifié (échec `psql` en auth "peer")

## 3. Vérifications à faire manuellement

Lancer :

```bash
cd /home/toxy/dossierlinux/week9/mardi/eventbrite_thp
bundle install
bin/rails runner "
  puts 'Blobs: ' + ActiveStorage::Blob.count.to_s
  puts 'Attachments: ' + ActiveStorage::Attachment.count.to_s
  ActiveStorage::Attachment.includes(:blob).each do |a|
    path = Rails.root.join('storage', a.blob.key[0..1], a.blob.key[2..3], a.blob.key)
    puts \"  #{a.record_type}##{a.record_id}.#{a.name} -> #{a.blob.key}\"
    puts \"    File exists: #{File.exist?(path)}\"
  end
"
```

## 4. Recommandations

- Vérifier que le fichier est bien envoyé dans le formulaire avant d’appeler `attach`
- S’assurer que `storage/` n’est pas supprimé ou vidé entre les sessions (Docker, scripts, etc.)
- Si tu utilises Docker, monter un volume pour `storage/`
