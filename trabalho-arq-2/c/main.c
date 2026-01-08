int calcularMedia(float total, int n)
{
  return total / n;
}

int somar(float notas[], int n)
{

  if (n == 0)
  {
    return 0;
  }
  return notas[n - 1] + somar(notas, n - 1);
}

int main()
{
  int qtd_notas;

  printf("Quantas notas deseja cadastrar? ");
  scanf("%d", &qtd_notas);

  float notas[qtd_notas];

  for (int i = 0; i < qtd_notas; i++)
  {
    printf("Digite a nota do aluno %d: ", i + 1);
    scanf("%f", &notas[i]);
  }

  float soma_das_notas = somar(notas, qtd_notas);
  float media_da_turma = calcularMedia(soma_das_notas, qtd_notas);

  printf("soma total das notas %f.0", soma_das_notas);

  return 1;
}