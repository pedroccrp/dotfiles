translate_oxean_api() {
  local password="$1"
  echo 'Vamos traduzir tudo para você :D'
  export GOOGLE_TRANSLATE_API_KEY="$password"
  RAILS_ENV=development i18n-tasks translate-missing --from en de, es, fr, nb, pt-BR, zh-CN, th;
  sed -i "s/\b'\b/'/g" config/locales/fr.yml # Replace ' to ’ in french
}
