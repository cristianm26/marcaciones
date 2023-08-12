String replaceUrl(String alias) {
  if (alias == 'desarrollo') {
    return 'https://desarrollo.twiinshrmprueba.com/talento_api/index.php';
  } else {
    return 'https://$alias.twiinshrm.com/talento_api/index.php';
  }
}
