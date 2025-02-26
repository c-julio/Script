# #!/bin/bash

# Ativar suporte a pacotes de 32 bits
echo "Ativando suporte a pacotes de 32 bits..."
sudo dpkg --add-architecture i386

# Atualizar pacotes
echo "Atualizando lista de pacotes..."
sudo apt update

# Adicionar chave e repositório do Wine
echo "Adicionando repositório do Wine..."
sudo mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$(lsb_release -cs)/winehq-$(lsb_release -cs).sources

# Atualizar novamente após adicionar o repositório
echo "Atualizando lista de pacotes novamente..."
sudo apt update

# Instalar Wine
if sudo apt install --install-recommends -y winehq-stable; then
    echo "Wine instalado com sucesso!"
else
    echo "Erro na instalação. Tentando corrigir pacotes quebrados..."
    sudo apt --fix-broken install -y
    sudo apt install -f -y
    sudo apt install --install-recommends -y winehq-stable
fi

# Verificar versão do Wine
wine --version
