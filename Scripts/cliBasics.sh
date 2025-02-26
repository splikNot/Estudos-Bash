#!/bin/bash



# Estrutura básica de uma CLI

# Ativando modo de segurança (Lembrando que eles podem ser ativos na shebang line);


set -euo pipefail

# set -e(exit(?)): Faz o script sair automaticamente quando encontra um erro.
# set -u: Faz o script ser interrompido quando uma caso alguma váriavel não seja devidamente definida
# set -o pipefail: Faz que a saída do script seja o primeiro erro que encontrar em uma pipeline


# Função de ajuda

function mostrar_ajuda {
    echo "Uso: $(basename "$0") [comando] [opções]" # Estrutura de comandos bash
    echo ""

    echo "Comandos Disponiveis: "
    echo "ajuda                     Mostra essa mensagem de ajuda"
    echo "saudacao                  Exibe uma saudção personalizada"
    echo "data                      Exibe a data e hora atuais"
    echo ""
    echo "Opções gerais:"
    echo " -h, --help               Mostra essa mensagem de ajuda"

}

function saudacao {
    local nome="${1:-usuário}" # Usa usuário por padrão quando nenhuma variável for definida
    echo "Olá, $nome! Bem vindo à minha ferramenta CLI"
}

function data {
    echo "A data e hora atuais são: $(date)"
}

# Processamento de comandos

case "${1:-}" in
    ajuda|-h|--help)
        mostrar_ajuda
        ;;
    saudacao|-s|--sallut)
        saudacao "$2"
        ;;
    data|-d|--datetime)
        data
        ;;
    *)
        echo "comando inválido: $1"
        echo "Use '$(basename "$0") ajuda' para ver os comandos disponíveis."
        exit 1
        ;;
esac



# O a sintaxe do comando case não precisa de abertura de parenteses.
# Depois vou montar uma mega documentação em bash para mostrar isso
