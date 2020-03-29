String porcentajeString(int numMenor, int numMayor) {
  return (numMenor * 100 / numMayor).toStringAsFixed(2) + "%";
}

double porcentajeDouble(int numMenor, int numMayor) {
  return double.parse((numMenor / numMayor).toStringAsFixed(2));
}
