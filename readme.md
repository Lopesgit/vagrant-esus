# Vagrant box para e-SUS-AB

## Características
* Máquina virtual Ubuntu 16.04 lts 64 bits (vagrant box ubuntu/xenial64);
* e-SUS-AB PEC versão 2.1.08 para treinamento;
* Acesso ao e-SUS-AB através de _http://localhost:8080/esus_ através do navegador da máquina real (_host_);
* Permite a realização de backups e restauração do banco de dados através de scripts automatizados.

## Requisitos obrigatórios para utilização da box
1. [Oracle VM VirtualBox e Oracle VM VirtualBox Extension Pack instalado e atualizado](https://www.virtualbox.org/wiki/Downloads)
3. [Vagrant na última versão disponível](https://www.vagrantup.com/downloads.html)
4. [Git instalado](https://git-scm.com/)
5. Plugins do vagrant:
    * [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)
    * [vagrant-triggers](https://github.com/emyl/vagrant-triggers)

#### Caso a box seja executada sob proxy será necessário instalar o plugin abaixo:

* [vagrant-proxyconf](https://github.com/tmatilai/vagrant-proxyconf)

## Utilização
1. Copie ou clone o este repositório para uma pasta desejada;
2. Criar a pasta _esus_backups_ dentro da pasta principal;
3. No prompt de comando execute o comando _vagrant up_;
    * Nesta etapa será criada e configurada uma máquina virtual (_guest_) e ao inicia-lá o vagrant executará o script que baixará e instalará o e-SUS-AB, e criará os scripts para iniciar e para o serviço do e-SUSAB e também para execução de backup e restauração do banco de dados.
4. Ao final da etapa 2 a máquina virtual estará inicializada e com o e-SUS-AB sendo executado e já com o backup do banco de dados em branco criado. Portanto, para verifica acessar o e-SUS-AB basta acessar o endereço _http://localhost:8080/esus_ no navegador.

### Acessando a máquina virtual(_guest_) e manipulando o banco de dados do e-SUS-AB
* Para acessar a máquina virtual(_guest_) execute o comando _vagrant ssh_ np prompt de comando e então será realizado o login na máquina sendo carregado o bash do Ubuntu.

### Executando backup do banco de dados do e-SUS-AB
* No bash do Ubuntu (acessando a máquina virtual via _vagrant ssh_) execute o comando *esus_bkp [nome_do_arquivo_de_bakcup]*, então será criado um arquivo na pasta _esus_backups_.

### Restaurando um backup do banco de dados do e-SUS-AB
* No bash do Ubuntu (acessando a máquina virtual via _vagrant ssh_) execute o comando *esus_rest [nome_do_arquivo_de_bakcup]*, então o banco de dados será restaurado a partir do arquivo de backup criado anteriormente na pasta _esus_backups_.

