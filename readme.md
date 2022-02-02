# Creación de una máquina de oracle desde IaaS 

Veremos como evoluciona, si a partir de una imagen limipia e instalamos con comandos, o casi mejor usar una ya con el oracle instalado.

Primero lo primero, hay que tener una clave ssh con la que nos conectaremos

# Creamos la cuenta ssh 
ssh-keygen -P "" -C "Usuario para Maquina Oracle" -t rsa -b 2048 -m pem -f ~/Oravm/orauser



