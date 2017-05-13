#!/bin/bash
# Autor: Marcos Ferreira da Rocha
# Email: marcos.fr.rocha@gmail.com
# Objetivo: Este script, faz uma instalação automatizada do libreoffice. 
# Versão: 1.0
# Data: 03/05/2017
# Nota : O script baixa as versões  Fresh ( Que oferece os mais  novos recursos também está mais próxima à versão de desenvolvimento) baixa também a versão Still ( Versão Estável e que oferece maior estabilidade que a versão fresh)

# 0 Aviso sobre o script
whiptail --title  "Esclarecimento" --msgbox  "O LibreOffice  é oferecido pela TDF | The Document Fundation
https://www.documentfoundation.org/

O https://pt-br.libreoffice.org é o portal da comunidade Brasileira.

Este script baixa e instala o LibreOffice Estável ou Novo, também conhecidos como Still e Fresh diretamente dos repositórios oficiais.
A lista pode ser extendida ou alterada de acordo com a sua necessidade, para ambientes  corporativos sugerimos a criação de 
um repositórios local para o LibreOffice,  assim como neste script.


Convidamo-lo a visitar a  página do projeto ( LibreOffice ).

http://www.libreoffice.org/ 

___________________________
Clique em Ok para continuar" 20 80

#1 Variável definindo que baixaremos o libreoffice no repositório estável
versaostatus="stable"

## Escolhendo a versão do LibreOffice
vs=$(whiptail --title " Escolher a Versão Nova ou Estável" --inputbox "Digite a Versão a ser instalada exemplo: 5.3.2:" --fb 10 60 3>&1 1>&2 2>&3)
statussaida=$?

#2 Aqui voĉe pode  inserir  uma lista de seus servidoes preferênciais para baixar o LibreOFfice, com a possiblidies de inserir  um servidor local, ideal para  ambientes  empresariais
 #Nesse caso utilizei o servidor em minha rede com o IP 192.168.50.122/tdf			

servidor=$(whiptail --title "Servidores FTP" --radiolist \
"Escolha o servidor para baixar o LibreOffice." 15 80 10 \
"http://tdf.c3sl.ufpr.br" "UFPR   " ON \
"http://linorg.usp.br/LibreOffice" "USP " OFF \
"http://ftp.unicamp.br/pub" "UNICAMP  " OFF \
"http://mirror.pop-sc.rnp.br/mirror/tdf" "PoP-SC "  OFF \
"http://mirror.nexcess.net/tdf" "Mirror nexcess" OFF \
"http://mirror.ufms.br/tdf/" "Mirror UFMS" OFF \
"http://tdf.ufes.br/" "Mirror UFES" OFF \
"http://mirror.unesp.br/tdf/" "Mirror Unesp" OFF \
"192.168.50.122/tdf" "Servidor Local "  OFF 3>&1 1>&2 2>&3)

#3 Testando  o gernciador de pacotes"

		if	 [ -e /usr/bin/rpm ]; then
  				gerenciadorPacote=rpm
  				diretorio=RPMS
 		else  
  				gerenciadorPacote=deb
  				diretorio=DEBS
		fi

#4 Testando  Arquitetura do desktop"

		if [ `getconf LONG_BIT` = "64" ]
		then
		     plafatorma=x86_64
			 plafatorma2=x86-64
		else
			plafatorma=x86
			plafatorma2=x86
		fi

#5 Escolhendo o idioma local
 idioma=$(whiptail --title "selecione idioma de instalação" --radiolist \
						"Escolha o idioma de instalação                Choose the installation language" 30 50 20 \
						"pt-BR"	"Portuguese (Brazil)" ON \
						"am"	"Amharic - አማርኛ" OFF \
						"ar"	"Arabic  - العربية  " OFF \
						"ast"	"Asturian" OFF \
						"bg"	"Bulgarian (Bulsgaria)	" OFF \
						"bn-IN"	"Bengali, India" OFF \
						"bn"	"Bengali" OFF \
						"bo"	"Tibetan Standard - བོད་ཡིག" OFF \
						"bs"	"Bosnian (Bosnia and Herzegovina)" OFF \
						"ca"	"Catalan" OFF \
						"cs"	"Czech" OFF \
						"da"	"Danish" OFF \
						"de"	"German" OFF \
						"dz"	"Dzongkha" OFF \
						"el"	"Greek" OFF \
						"en-US"	"English United Stats"  OFF \
						"en-GB"	"English (United Kingdom)" OFF \
						"en-ZA"	"English (South Africa)" OFF \
						"eo"	"Esperanto" OFF \
						"es"	"Spanish" OFF \
						"et"	"Estonian" OFF \
						"eu"	"Basque" OFF \
						"fi"	"Finnish" OFF \
						"fr"	"French" OFF \
						"gl"	"Galician" OFF \
						"gu"	"Gujarati" OFF \
						"he"	"Hebrew" OFF \
						"hi"	"Hindi" OFF \
						"hr"	"Croatian" OFF \
						"hu"	"Hungarian" OFF \
						"id"	"Indonesian" OFF \
						"is"	"Icelandic" OFF \
						"it"	"Italian" OFF \
						"ja"	"Japanese" OFF \
						"ka"	"Georgian" OFF \
						"km"	"Khmer" OFF \
						"ko"	"Korean" OFF \
						"lo"	"Lao" OFF \
						"lt"	"Lithuanian" OFF \
						"lv"	"Latvian" OFF \
						"mk"	"FYRO Macedonian" OFF \
						"nb"	"Norwegian (Bokm?l)" OFF \
						"ne"	"Nepali" OFF \
						"nl"	"Dutch" OFF \
						"nn"	"Norwegian Nynorsk" OFF \
						"om"	"Oromo" OFF \
						"pl"	"Polish" OFF \
						"pt"	"Portuguese" OFF \
						"ro"	"Romanian" OFF \
						"ru"	"Russian" OFF \
						"si"	"Sinhala; Sinhalese" OFF \
						"sid"	"Sidamo" OFF \
						"sk"	"Slovak" OFF \
						"sl"	"Slovenian" OFF \
						"sq"	"Albanian" OFF \
						"sv"	"Swedish" OFF \
						"ta"	"Tamil" OFF \
						"tg"	"Tajik" OFF \
						"tr"	"Turkish" OFF \
						"ug"	"Uyghur" OFF \
						"uk"	"Ukrainian" OFF \
						"vi"	"Vietnamese (Viet Nam)" OFF \
						"zh-CN"	"Chinese Simplified" OFF \
						"zh-TW"	"Chinese Traditional"  OFF 3>&1 1>&2 2>&3)							
						status=$?
						if [ $status = 0 ]
						then
										# Criando diretório para  baixar os pacotes de acordo como versão, gerenciador, arquitetura
										mkdir -m 777 -p "/home/"$USER"/Downloads/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma""
										destino="/home/"$USER"/Downloads/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma""

#6										#Baixando o LibreOffice
							  			sudo -s wget -c "$servidor"/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz	 -P "$destino"

							  			sudo -s wget -c "$servidor"/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma".tar.gz	 -P "$destino"

#7							  			# Testando se a necessidade de baixar o pacote idioma, no caso do idioma inglÊs não há necessidade.	
							  			if	! [  "$idioma" = "en-US" ]
							  			then
							  			sudo -s wget -c "$servidor"/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma".tar.gz	 -P "$destino"
							  			else 
							  			echo "O LibreOffice é en-US nativo, não há necessidade de instalar o pacote de Linguagem en-US"  
							  			fi

#8							  				#Testando se o pacote Core do LibreOffice foi instalado para dar continuidade ao processso, caso afirmativo ocorre um teste de gerenciador de pacotes para desinstalar a verão anterior do LO. 
						  					if	[ -e "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz ]
											  	then
												 if [ -e /usr/bin/yum  ]; then
												 	sudo -s yum remove openoffice* libreoffice* -y

												 elif [ -e /usr/bin/zypper  ]; then
													sudo -s zypper -n remove libreoffice*
						  						
						  						elif [ -e /usr/bin/zypper ]; then
													sudo -s zypper -n remove openoffice*

												 elif [ -e /usr/bin/dpkg  ]; then
												  	sudo -s apt-get remove --purge libreoffice* -y	

												else
						  							echo "gerenciador de pacotes não econtrado"

						  						fi
							  					
# 9							  					# Descompactando os pacotes Libre Office

							  						sudo -s tar -xzf  "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz	 -C /tmp
							  					
#10							  					# Testando a necessidade de instalar Pacote de Idioma
							  					if	! [  "$idioma" = "en-US" ]
							  					then
							  					  	sudo -s tar -xzf  "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma".tar.gz	 -C /tmp
							  					else 
							  						echo "O LibreOffice é en-US nativo, não há necessidade de instalar o pacote de Linguagem en-US"  
							  					fi
							  					
#11							  					# Instalação do Pacote de Ajuda
							  						sudo -s tar -xzf   "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma".tar.gz	 -C /tmp

							  					# Aqui ocorre a instalação do pacote principal do Libre Office
							  					
#12							  					#PACOTE ACORE
							  					tar -tzf    "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz |  cut -d '_' -f2  | uniq  >  subversao
							  					valorsubversao=$(<subversao)
							  					
							  						if [ -e /usr/bin/dpkg  ]; then
							  						sudo -s dpkg -i /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"/"$diretorio"/*
							  						else
							  						sudo -s rpm -Uvh /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"/"$diretorio"/*
							  						fi
							  					
#13							  					##Instalação do PACOTE DE LINGUAGEM

							  					if	! [  "$idioma" = "en-US" ]
							  					then
							  					    tar -tzf    "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz |  cut -d '_' -f2  | uniq  >  subversao
							  					    valorsubversao=$(<subversao)					  					    

							  					    	if [ -e /usr/bin/dpkg  ]; then
							  					    	sudo -s dpkg -i /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma"/"$diretorio"/*
							  					    	else
							  					    	sudo -s rpm -Uvh /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma"/"$diretorio"/*
							  					    	fi
						  					    
							  					else 
							  						echo "O LibreOffice é en-US nativo, não há necessidade de instalar o pacote de Linguagem en-US"  
							  					fi
							  					
#14							  					##PACOTE DE AJUDA
							  					tar -tzf    "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz |  cut -d '_' -f2  | uniq  >  subversao
							  					valorsubversao=$(<subversao)


							  						if [ -e /usr/bin/dpkg  ]; then
							  						sudo -s dpkg -i /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma"/"$diretorio"/*
							  						else
							  						sudo -s rpm -Uvh /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma"/"$diretorio"/*
							  						fi
							  			else
							  					echo  "Não há versão solicitada"
							  			fi	
#15							# Tratando os arquivos utilizados, no momento enviando para um subdiretório do Downloads
							
									sudo -s rm subversao
#16					  	
						else	#Caso o usário cancele no momento de escolher o idioma 
						echo "Instalação Cancelada pelo usuário"		
					  	fi
					
	
