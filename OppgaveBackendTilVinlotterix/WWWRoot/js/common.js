﻿function getDateStringForDisplay(dato) {
  return dato.toLocaleString().replace(',', '').substr(0, 16);
}

function getDateStringForStorage(dato) {
  return dato.toISOString().substr(0, 16).replace('T', ' ');
}

function getNowForStorage() {
  return getDateStringForStorage(new Date());
}