#include <stdio.h>

#define MAX 100

int soma_saldos(int v[], int n)
{
  if (n == 0)
    return 0;
  return v[n - 1] + soma_saldos(v, n - 1);
}

int maior_saldo(int v[], int n)
{
  int maior = v[0];
  for (int i = 1; i < n; i++)
    if (v[i] > maior)
      maior = v[i];
  return maior;
}

int menor_saldo(int v[], int n)
{
  int menor = v[0];
  for (int i = 1; i < n; i++)
    if (v[i] < menor)
      menor = v[i];
  return menor;
}

void depositar(int v[], int n, int i, int valor)
{
  if (i < 0 || i >= n)
  {
    printf("Cliente inexistente\n");
    return;
  }

  v[i] += valor;
  printf("Deposito realizado\n");
}

void sacar(int v[], int n, int i, int valor)
{
  if (i < 0 || i >= n)
  {
    printf("Cliente inexistente\n");
    return;
  }
  if (v[i] >= valor)
  {
    v[i] -= valor;
    printf("saque realizado");
  }
  else
    printf("Saldo insuficiente!\n");
}

int main()
{
  int n, op, cliente, valor;
  int saldos[MAX];

  printf("Quantidade de clientes: ");
  scanf("%d", &n);

  for (int i = 0; i < n; i++)
  {
    printf("Saldo inicial do cliente %d: ", i+1);
    scanf("%d", &saldos[i]);
  }

  do
  {
    printf("\n1-Depositar  2-Sacar  3-Estatisticas  4-Sair\n");
    scanf("%d", &op);

    if (op == 1)
    {
      printf("Cliente: ");
      scanf("%d", &cliente);
      printf("Valor: ");
      scanf("%d", &valor);
      depositar(saldos,n, cliente, valor);
    }

    else if (op == 2)
    {
      printf("Cliente: ");
      scanf("%d", &cliente);
      printf("Valor: ");
      scanf("%d", &valor);
      sacar(saldos, n, cliente, valor);
    }

    else if (op == 3)
    {
      printf("Total no banco: %d\n", soma_saldos(saldos, n));
      printf("Maior saldo: %d\n", maior_saldo(saldos, n));
      printf("Menor saldo: %d\n", menor_saldo(saldos, n));
    }

  } while (op != 4);

  return 0;
}
