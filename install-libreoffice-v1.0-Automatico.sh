#!/bin/bash
# Autor: Marcos Ferreira da Rocha
# Email: marcos.fr.rocha@gmail.com
# Objetivo: Este script, faz uma instalação automatizada do libreoffice. 
# Versão: 1.0
# Data: 03/05/2017
# Nota : O script baixa as versões  Fresh ( Que oferece os mais  novos recursos também está mais próxima à versão de desenvolvimento) baixa também a versão Still ( Versão Estável e que oferece maior estabilidade que a versão fresh)

# 0 Aviso sobre o script
#"Esclarecimento" --msgbox  "O LibreOffice  é oferecido pela TDF | The Document Fundation
#https://www.documentfoundation.org/

#O https://pt-br.libreoffice.org é o portal da comunidade Brasileira.

#Este script baixa e instala o LibreOffice Estável ou Novo, também conhecidos como Still e Fresh diretamente dos repositórios oficiais.
#A lista pode ser extendida ou alterada de acordo com a sua necessidade, para ambientes  corporativos sugerimos a criação de 
#um repositórios local para o LibreOffice,  assim como neste script.

#Convidamo-lo a visitar a  página do projeto ( LibreOffice ).

#http://www.libreoffice.org/ 



#1 Variável definindo que baixaremos o libreoffice no repositório estável
versaostatus="stable"

## Escolhendo a versão do LibreOffice
vs=5.3.3
#2 Aqui voĉe pode  inserir  uma lista de seus servidoes preferênciais para baixar o LibreOFfice, com a possiblidies de inserir  um servidor local, ideal para  ambientes  empresariais
 #Nesse caso utilizei o servidor em minha rede com o IP 192.168.50.122/tdf			

servidor="http://tdf.c3sl.ufpr.br"
#Escolha o servidor para baixar o LibreOffice." 
#	"http://tdf.c3sl.ufpr.br" 						"UFPR   "
#	"http://linorg.usp.br/LibreOffice" 				"USP " 
#	"http://ftp.unicamp.br/pub" 					"UNICAMP  " 
#	"http://mirror.pop-sc.rnp.br/mirror/tdf" 		"PoP-SC "  
#	"http://mirror.nexcess.net/tdf" 				"Mirror nexcess" 
#	"http://mirror.ufms.br/tdf" 					"Mirror UFMS" 
#	"http://tdf.ufes.br/" 							"Mirror UFES" 
#	"http://mirror.unesp.br/tdf" 					"Mirror Unesp" 
# "192.168.50.122/tdf" 								"Servidor Local "  


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
idioma="pt-BR"
#						"Lista de idiomas diposniveis

#						"pt-BR"	"Portuguese (Brazil)" 
#						"am"	"Amharic - አማርኛ"
#						"ar"	"Arabic  - العربية  " 
#						"ast"	"Asturian" 
#						"bg"	"Bulgarian (Bulsgaria)	" 
#						"bn-IN"	"Bengali, India" 
#						"bn"	"Bengali" 
#						"bo"	"Tibetan Standard - བོད་ཡིག"
#						"bs"	"Bosnian (Bosnia and Herzegovina)" 
#						"ca"	"Catalan" 
#						"cs"	"Czech" 
#						"da"	"Danish" 
#						"de"	"German" 
#						"dz"	"Dzongkha" 
#						"el"	"Greek" 
#						"en-US"	"English United Stats" 
#						"en-GB"	"English (United Kingdom)" \
#						"en-ZA"	"English (South Africa)"
#						"eo"	"Esperanto" 
#						"es"	"Spanish" 
#						"et"	"Estonian" 
#						"eu"	"Basque" 
#						"fi"	"Finnish" 
#						"fr"	"French" 
#						"gl"	"Galician" 
#						"gu"	"Gujarati" 
#						"he"	"Hebrew" 
#						"hi"	"Hindi" 
#						"hr"	"Croatian" 
#						"hu"	"Hungarian" 
#						"id"	"Indonesian" 
#						"is"	"Icelandic" 
#						"it"	"Italian" 
#						"ja"	"Japanese" 
#						"ka"	"Georgian" 
#						"km"	"Khmer" 
#						"ko"	"Korean" 
#						"lo"	"Lao" 
#						"lt"	"Lithuanian" 
#						"lv"	"Latvian" 
#						"mk"	"FYRO Macedonian" 
#						"nb"	"Norwegian (Bokm?l)" 
#						"ne"	"Nepali" 
#						"nl"	"Dutch" 
#						"nn"	"Norwegian Nynorsk" 
#						"om"	"Oromo" 
#						"pl"	"Polish" 
#						"pt"	"Portuguese" 
#						"ro"	"Romanian" 
#						"ru"	"Russian" 
#						"si"	"Sinhala; Sinhalese" 
#						"sid"	"Sidamo" 
#						"sk"	"Slovak" 
#						"sl"	"Slovenian" 
#						"sq"	"Albanian" 
#						"sv"	"Swedish" 
#						"ta"	"Tamil" 
#						"tg"	"Tajik" 
#						"tr"	"Turkish" 
#						"ug"	"Uyghur" 
#						"uk"	"Ukrainian" 
#						"vi"	"Vietnamese (Viet Nam)" 
#						"zh-CN"	"Chinese Simplified" 
#						"zh-TW"	"Chinese Traditional"  OFF 3>&1 1>&2 2>&3)							
#						status=$?

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
	
