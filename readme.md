# Creación de una máquina de oracle desde IaaS 

## Instrucciones de uso

### Clonamos el repositorio en la consola de azure 
  > git clone https://github.com/victhor666/Oravm.git

lo dejará todo en   /home/[tu-usuario]/Oravm

### Creamos la cuenta ssh 
  > cd Oravm 
  
  > ssh-keygen -P "" -C "Usuario para Maquina Oracle" -t rsa -b 2048 -m pem -f ~/Oravm/orauser

dejará un fichero orauser con la clave privada y un orauser.pub con la publica

### Modificamos el fichero de parámetros con los datos que queramos cambiar. Podemos cambiar los siguientes:

- prefix-->Prefijo para toda la nomenclatura, por defecto será Ora, pero se puede poner cualquier cosa.
- az_location--> por defecto está en eastus pero lo podemos poner en cualquier sitio, por ejemplo westeurope o 
- vnet_cidr--> vnet a asignar. Esto hay que cabmiarlo is se pisa con alguna existente en la region, por defecto es 192.168.0.0/16"
- subnet_cidr-->tiene que estar en consonancia con la anterior, por defecto es 192.168.10.0/24. También se puede hacer más pequeña, no nos harán falta 250 hosts!
- servername-->Nombre de la instancia, por defecto, OraVM
- osdisk_size-->Disco del sistema, por defecto 30GB que deberían sobrar
- disco2_size-->disco de instalación de oracle. Con 30GB que es lo que hay por defecto debería valer
- disco3_size-->disco para DATA, aqui hay que poner el tamaño del volumen de asm que querremos para los datos 50GB 1TB
- vm_size-->Tamaño de la máquina Usar máquinas con más de menos 8GB de memoria y >15GB de disco temporal , por defecto será una Standard_B4ms
- DATABASENAME-->Nombre que le daremos a la base de datos que se creará al final, por defecto ORCLBBDD
 
 *** hay algun parametro mas modificable, pero estos son los mas importantes y/o susceptibles a ser cambiados ***

### Inicializamos terraform
  > terraform init

### Verificamos que todo es correcto
  > terraform plan

### Desplegamos la infra
  > terraform apply --auto-approve

Esto empezará a desplegar la red (VPC) subred, grupos de seguridad etc etc. 

AL cabo de unos minutos la máquina será accesible pero irá desplegando todo lo que hay en el fichero userdata.txt, que s mucho. El grid, software, parches, más parches, usuarios permisos. Tardará no menos de una hora y media en estar lista. Pero antes (a los pocos minutos) se puede acceder a la máquina
  (desde /home/[usuario]/Oravm)
  > ssh -i oravm azureuser@[ip-publica-de-la-maquina]

Aqui podremos ver la evolución en /tmp/script.log haciendo
  > tail -f /tmp/script.log

### Cuando termine podremos acceder a la bbdd con el nombre que hayamos definido en el fichero de configuración
##### La contraseña por defecto de la bbdd está en ***/oracle_base/DEFAULT_SYS_PASS.txt***
(No está en ningún sitio mas que ese, y es con acceso de root, pero se recomienda cambiarla)

Y esto es todo, que no es poco. 


