# Vagrant box para e-SUS-AB

## Caracter�sticas
* M�quina virtual Ubuntu 16.04 lts 64 bits (vagrant box ubuntu/xenial64);
* e-SUS-AB PEC vers�o 2.1.08 para treinamento;
* Acesso ao e-SUS-AB atrav�s de _http://localhost:8080/esus_ atrav�s do navegador da m�quina real (_host_);
* Permite a realiza��o de backups e restaura��o do banco de dados atrav�s de scripts automatizados.

## Requisitos obrigat�rios para utiliza��o da box
1. [Oracle VM VirtualBox e Oracle VM VirtualBox Extension Pack instalado e atualizado](https://www.virtualbox.org/wiki/Downloads)
3. [Vagrant na �ltima vers�o dispon�vel](https://www.vagrantup.com/downloads.html)
4. [Git instalado](https://git-scm.com/)
5. Plugins do vagrant:
    * [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)
    * [vagrant-triggers](https://github.com/emyl/vagrant-triggers)

#### Caso a box seja executada sob proxy ser� necess�rio instalar o plugin abaixo:

* [vagrant-proxyconf](https://github.com/tmatilai/vagrant-proxyconf)

## Utiliza��o
1. Copie ou clone o este reposit�rio para uma pasta desejada;
2. Criar a pasta _esus_backups_ dentro da pasta principal;
3. No prompt de comando execute o comando _vagrant up_;
    * Nesta etapa ser� criada e configurada uma m�quina virtual (_guest_) e ao inicia-l� o vagrant executar� o script que baixar� e instalar� o e-SUS-AB, e criar� os scripts para iniciar e para o servi�o do e-SUSAB e tamb�m para execu��o de backup e restaura��o do banco de dados.
4. Ao final da etapa 2 a m�quina virtual estar� inicializada e com o e-SUS-AB sendo executado e j� com o backup do banco de dados em branco criado. Portanto, para verifica acessar o e-SUS-AB basta acessar o endere�o _http://localhost:8080/esus_ no navegador.

### Acessando a m�quina virtual(_guest_) e manipulando o banco de dados do e-SUS-AB
* Para acessar a m�quina virtual(_guest_) execute o comando _vagrant ssh_ np prompt de comando e ent�o ser� realizado o login na m�quina sendo carregado o bash do Ubuntu.

### Executando backup do banco de dados do e-SUS-AB
* No bash do Ubuntu (acessando a m�quina virtual via _vagrant ssh_) execute o comando *esus_bkp [nome_do_arquivo_de_bakcup]*, ent�o ser� criado um arquivo na pasta _esus_backups_.

### Restaurando um backup do banco de dados do e-SUS-AB
* No bash do Ubuntu (acessando a m�quina virtual via _vagrant ssh_) execute o comando *esus_rest [nome_do_arquivo_de_bakcup]*, ent�o o banco de dados ser� restaurado a partir do arquivo de backup criado anteriormente na pasta _esus_backups_.

