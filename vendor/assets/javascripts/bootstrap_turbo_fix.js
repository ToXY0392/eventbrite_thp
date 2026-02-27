// Réinitialise les composants Bootstrap après chaque chargement de page (Turbo + initial)
function initBootstrapComponents() {
  if (typeof bootstrap === "undefined") return;

  // Dropdowns : getOrCreateInstance évite les doublons
  document.querySelectorAll('[data-bs-toggle="dropdown"]').forEach(function (el) {
    try {
      bootstrap.Dropdown.getOrCreateInstance(el);
    } catch (e) {
      // Si erreur, forcer une nouvelle instance après dispose
      var instance = bootstrap.Dropdown.getInstance(el);
      if (instance) instance.dispose();
      new bootstrap.Dropdown(el);
    }
  });

  // Collapse (navbar mobile)
  document.querySelectorAll('[data-bs-toggle="collapse"]').forEach(function (btn) {
    var targetId = btn.getAttribute("data-bs-target");
    if (targetId) {
      var target = document.querySelector(targetId);
      if (target) {
        bootstrap.Collapse.getOrCreateInstance(target, { toggle: false });
      }
    }
  });
}

document.addEventListener("turbo:load", initBootstrapComponents);
document.addEventListener("DOMContentLoaded", initBootstrapComponents);
