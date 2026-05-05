# Simulador de Crédito SFN (Sistema Financeiro Nacional)

![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white)
![Next JS](https://img.shields.io/badge/Next-black?style=for-the-badge&logo=next.js&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Prisma](https://img.shields.io/badge/Prisma-3982CE?style=for-the-badge&logo=Prisma&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Jest](https://img.shields.io/badge/Jest-C21325?style=for-the-badge&logo=jest&logoColor=white)

Uma aplicação Full-Stack desenvolvida para simular operações de crédito de acordo com as regras matemáticas exigidas pelo Sistema Financeiro Nacional brasileiro. O projeto aplica rigorosamente os sistemas de amortização **SAC** (Sistema de Amortização Constante) e **PRICE** (Tabela Francesa).

O grande diferencial deste projeto é a sua base estrutural fundamentada em **Arquitetura Hexagonal (Ports and Adapters)**, garantindo que o coração da aplicação (as regras matemáticas e financeiras) seja 100% isolado de frameworks, banco de dados ou interfaces de usuário.

## Funcionalidades

- **Simulação Precisa:** Cálculo exato de parcelas, amortização, juros e saldo devedor utilizando `decimal.js` para evitar a perda de precisão flutuante (problema clássico de 0.1 + 0.2).
- **Sistemas Suportados:**
  - Tabela PRICE (Prestações fixas).
  - Sistema SAC (Amortizações fixas e prestações decrescentes).
- **Tratamento de Resíduos:** Implementação de regras de negócio reais de instituições financeiras, como o ajuste de centavos residuais na última parcela para zeramento perfeito do saldo devedor.
- **Persistência de Dados:** Histórico de simulações salvo em banco de dados relacional.
- **Pipeline de CI/CD:** Testes unitários e verificação de build automatizados via GitHub Actions a cada *commit*.

## Arquitetura (Hexagonal)

A aplicação foi dividida em camadas lógicas estritas:

1. **Domain (Core):** Contém as `Strategies` de cálculo (SAC e Price) e as entidades do negócio. Não importa NENHUMA biblioteca externa (exceto ferramentas de precisão matemática).
2. **Application (Use Cases):** Orquestra o fluxo de dados, recebendo a requisição, chamando o domínio para calcular e enviando para o repositório salvar.
3. **Infrastructure (Adapters):** Implementações concretas de tecnologia, como o `PrismaSimulationRepository` (que conversa com o Postgres) e a interface web (Componentes e Rotas do Next.js).

## Como executar o projeto localmente

### Pré-requisitos
- [Node.js](https://nodejs.org/en/) (v18 ou superior)
- [Docker](https://www.docker.com/) e Docker Compose

### Passo a passo

1. **Clone o repositório**
   ```bash
   git clone [https://github.com/SEU_USUARIO/sfn-simulator.git](https://github.com/SEU_USUARIO/sfn-simulator.git)
   cd sfn-simulator
   ```

2. **Configure as Variáveis de Ambiente**
   Crie um arquivo `.env` na raiz do projeto com as credenciais do banco de dados:
   ```env
   DATABASE_URL="postgresql://sfn_admin:sfn_password_123@localhost:5435/credit_simulator?schema=public"
   ```

3. **Inicie o Banco de Dados com Docker**
   ```bash
   docker-compose up -d
   ```

4. **Instale as dependências e rode as Migrations**
   ```bash
   npm install
   npx prisma migrate dev
   ```

5. **Inicie o Servidor de Desenvolvimento**
   ```bash
   npm run dev
   ```
   Acesse a aplicação em `http://localhost:3000`.

## Testes Unitários

Para garantir a confiabilidade matemática das simulações, o domínio financeiro está coberto por testes automatizados.

```bash
# Executar a suíte de testes do Jest
npm run test
```

Os testes validam:
- A geração correta do número de parcelas (Mês 0 + prazo).
- A constância da amortização (SAC) e da prestação (PRICE).
- O comportamento do saldo devedor e os ajustes de centavos na liquidação do contrato.

## Stack Tecnológica

- **Frontend & Backend:** Next.js (App Router), React, TypeScript.
- **Estilização:** Tailwind CSS.
- **Banco de Dados:** PostgreSQL.
- **ORM:** Prisma.
- **Testes:** Jest.
- **Matemática Financeira:** Decimal.js.
- **DevOps:** Docker, GitHub Actions (CI/CD).