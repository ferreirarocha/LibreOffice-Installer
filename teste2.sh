#!/bin/bash 
#Autor: Marcos Ferreira da Rocha
#Email: marcos.fr.rocha@gmail.com
#Blog:  alfabech.com
#Onde o econtra, Grupo de LibreOffice no Telegram https://t.me/libreofficebr, https://t.me/libreofficebrasil
#Versão: 1.0 
#Ano: 18 de Maio 2017


exec >& >(tee -a /tmp/$(date +"%d-%m-%y"--%Hhoras:%mmin:%Sseg)-install-libreoffice.log)
export PATH="/usr/local/sbin:/usr/sbin:/sbin:/bin:/usr/games:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
#Baixando a arquivo de aviso sobre o script


          if [ -e /usr/bin/dnf  ]; then

                wget -c https://raw.githubusercontent.com/ferreirarocha/install-libreoffice/master/aviso -P /tmp
                FILE=/tmp/aviso
                zenity --text-info --width=800 --height=600 \
                --title="Sobre o LibreOffice" \
                --filename=$FILE  
               
          else
                zenity --text-info --html --width=800 --height=600 \
                --title="Sobre o LibreOffice" \
                --url=http://pt-br.libreoffice.org

          fi  
case $? in
    0)
        echo "Iniciar Instalação!"
	# próximo passo
	           versaostatus="stable"

             ## Escolhendo a versão do LibreOffice
             vs=$(zenity --entry --title="Insira a Versao" --text="versão:")
	        if [ $? == 0 ]; then		     
             #2 Aqui voĉe pode  inserir  uma lista de seus servidoes preferênciais para baixar o LibreOFfice, com a possiblidies de inserir  um servidor local, ideal para  ambientes  empresariais
              #Nesse caso utilizei o servidor em minha rede com o IP 192.168.0.193/tdf     

            servidor=$(zenity --list --radiolist --width=450 --height=400 \
            --title="Escolha o servidor  espelho" \
            --text="Selecione o servidor para realizar o download  dos pacotes do LibreOffice"  \
            --column="Seleção" --column="Link" --column="Instituição" \
              TRUE  http://tdf.c3sl.ufpr.br "UFPR" \
              FALSE http://linorg.usp.br/LibreOffice "USP"  \
              FALSE http://ftp.unicamp.br/pub "UNICAMP"  \
              FALSE http://mirror.pop-sc.rnp.br/mirror/tdf  "Pop-SC"  \
              FALSE http://mirror.nexcess.net/tdf "Mirror Nexcess"  \
              FALSE http://mirror.ufms.br/tdf "Mirror UFMS"  \
              FALSE http://tdf.ufes.br "Mirror UFES"  \
              FALSE 192.168.0.193/tdf  "Servidor Local" )

            if [ $? == 0 ]; then       

             #3 Testando  o gernciador de pacotes"
                if   [ -e "/bin/rpm" ]; then
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
              idioma=$(zenity --list --radiolist --width=450 --height=500 \
               --title="Escolha os defeitos que deseja ver" \
               --column="Seleção" --column="Cod. Idioma" --column="Idioma" \
                 TRUE  pt-BR  "Portuguese (Brazil)"  \
                 FALSE am "Amharic - አማርኛ"  \
                 FALSE ar "Arabic  - العربية  "  \
                 FALSE ast  "Asturian"  \
                 FALSE bg "Bulgarian (Bulsgaria)  "  \
                 FALSE bn-IN  "Bengali, India"  \
                 FALSE bn "Bengali"  \
                 FALSE bo "Tibetan Standard - བོད་ཡིག"  \
                 FALSE bs "Bosnian (Bosnia and Herzegovina)"  \
                 FALSE ca "Catalan"  \
                 FALSE cs "Czech"  \
                 FALSE da "Danish"  \
                 FALSE de "German"  \
                 FALSE dz "Dzgkha"  \
                 FALSE el "Greek"  \
                 FALSE en-US  "English United Stats"   \
                 FALSE en-GB  "English (United Kingdom)"  \
                 FALSE en-ZA  "English (South Africa)"  \
                 FALSE eo "Esperanto"  \
                 FALSE es "Spanish"  \
                 FALSE et "Estian"  \
                 FALSE eu "Basque"  \
                 FALSE fi "Finnish"  \
                 FALSE fr "French"  \
                 FALSE gl "Galician"  \
                 FALSE gu "Gujarati"  \
                 FALSE he "Hebrew"  \
                 FALSE hi "Hindi"  \
                 FALSE hr "Croatian"  \
                 FALSE hu "Hungarian"  \
                 FALSE id "Indesian"  \
                 FALSE is "Icelandic"  \
                 FALSE it "Italian"  \
                 FALSE ja "Japanese"  \
                 FALSE ka "Georgian"  \
                 FALSE km "Khmer"  \
                 FALSE ko "Korean"  \
                 FALSE lo "Lao"  \
                 FALSE lt "Lithuanian"  \
                 FALSE lv "Latvian"  \
                 FALSE mk "FYRO Macedian"  \
                 FALSE nb "Norwegian (Bokm?l)"  \
                 FALSE ne "Nepali"  \
                 FALSE nl "Dutch"  \
                 FALSE nn "Norwegian Nynorsk"  \
                 FALSE om "Oromo"  \
                 FALSE pl "Polish"  \
                 FALSE pt "Portuguese"  \
                 FALSE ro "Romanian"  \
                 FALSE ru "Russian"  \
                 FALSE si "Sinhala; Sinhalese"  \
                 FALSE sid  "Sidamo"  \
                 FALSE sk "Slovak"  \
                 FALSE sl "Slovenian"  \
                 FALSE sq "Albanian"  \
                 FALSE sv "Swedish"  \
                 FALSE ta "Tamil"  \
                 FALSE tg "Tajik"  \
                 FALSE tr "Turkish"  \
                 FALSE ug "Uyghur"  \
                 FALSE uk "Ukrainian"  \
                 FALSE vi "Vietnamese (Viet Nam)"  \
                 FALSE zh-CN  "Chinese Simplified"  \
                 FALSE zh-TW  "Chinese Traditial" )           
                        status=$?
                        if [ $status = 0 ]
                        then

                          while true
                          do
                              resp=$(zenity --password --text "Insira a sua senha" --title "Autenticação")

                              # Pega a senha do login gráfico
                              senha=$(echo "$resp" | cut -f1 -d'|')
                                      (
                                      echo "1" ; sleep 1
                                      echo "# Criando diretórios" ; sleep 1
                                      # Passa a senha
                                      echo $senha | sudo -S -u root zenity --info --text "Iniciando instalação \n Salve os trabalhos aberto no libreoffice e clique em OK" 
                                      
                                      if ! [ -e /usr/bin/notify-send  ]; then
                                          
                                            if [ -e /usr/bin/dnf  ]; then
                                                sudo -S  dnf install notify-send -y

                                            elif [ -e /usr/bin/zypper  ]; then
                                                sudo -S  zypper -n install notify-send
                                                                    
                                            elif [ -e /usr/bin/zypper ]; then
                                                sudo -S zypper -n install notify-send

                                            elif [ -e /usr/bin/dpkg  ]; then
                                                sudo -S  apt-get install notify-send -y

                                            else
                                                echo "gernciador não encontrado"  
                                            fi
                                      else
                                          echo "notify-send já instalado"      

                                      fi                                                                  
                                      echo "5" ; sleep 1
                                      echo "# Criando diretórios" ; sleep 1
                                      # Criando diretório para  baixar os pacotes de acordo como versão, gerenciador, arquitetura
                                      #rm lixeiratemp
                                      mkdir -m 777 -p "/home/"$USER"/Downloads/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma"" 
                                      destino="/home/"$USER"/Downloads/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma""   

#6                                    #Baixando o LibreOffice
                                      ##notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Baixando pacotes !'  

                                      echo "10" ; sleep 1
                                      echo "# Baixando o pacote principal" ; sleep 1       
                                      wget -c "$servidor"/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz  -P "$destino" 

                                      echo "20" ; sleep 1
                                      echo "# Baixando o pacote de ajuda" ; sleep 1       
                                      wget -c "$servidor"/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma".tar.gz   -P "$destino" 

#7                                    # Testando se há necessidade de baixar o pacote idioma, no caso do idioma inglÊs não há necessidade. 
                                       if  ! [  "$idioma" = "en-US" ]
                                             then
                                                  echo "30" ; sleep 1
                                                  echo "# Baixando o pacote de idioma" ; sleep 1 
                                                  wget -c "$servidor"/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma".tar.gz   -P "$destino" 
                                        else 
                                                   exit 1   
                                        fi

                                      echo "40" ; sleep 1
                                      echo "# Removendo versão anterior" ; sleep 1 
#8                                    #Testando se o pacote Core do LibreOffice foi baixado para dar continuidade ao processso, caso afirmativo ocorre um teste de gerenciador de pacotes para desinstalar a verão anterior do Libre Office. 
                                      ##notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Removendo versão anterior '$comparar-versao-instalada'. !'      
                                      if  [ -e "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz ]
                                          then
                                                  if [ -e /usr/bin/dnf  ]; then
                                                      sudo -S  dnf remove openoffice* libreoffice* -y

                                                  elif [ -e /usr/bin/zypper  ]; then
                                                      sudo -S  zypper -n remove libreoffice[0-9]*
                                                                          
                                                  elif [ -e /usr/bin/zypper ]; then
                                                      sudo -S zypper -n remove openoffice[0-9]*

                                                  elif [ -e /usr/bin/dpkg  ]; then
                                                      sudo -S  apt-get remove --purge libreoffice[0-9]* -y  

                                                  else
                                                      echo "LibreOffice não encontrado, continuar instalação"  
                                                  fi
                                                                                  
#9                                        # Descompactando os pacotes Libre Office
                                          ##notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Extraindo pacotes !' 
                                                                                      
                                          echo "50" ; sleep 1
                                          echo "# Descompactando pacote principal" ; sleep 1         

                                          tar -xzf  "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz  -C /tmp 
                                                                                  
#10                                       # Testando a necessidade de instalar Pacote de Idioma
                                                if  ! [  "$idioma" = "en-US" ]
                                                    then

                                          echo "60" ; sleep 1
                                          echo "# Descompactando  o pacote de idioma" ; sleep 1 
                                          tar -xzf  "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma".tar.gz   -C /tmp 
                                                else 
                                                  exit 1  
                                                fi
                                                                                  
#11                                       # Instalação do Pacote de Ajuda
                                          echo "70" ; sleep 1
                                          echo "# Descompactando o pacote  de ajuda" ; sleep 1     
                                          tar -xzf   "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma".tar.gz  -C /tmp 

                                          # Aqui ocorre a instalação do pacote principal do Libre Office
                                                                                  
#12                                       #PACOTE ACORE
                                          ##notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Instalando pacotes principal!'   
                                          tar -tzf    "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz |  cut -d '_' -f2  | uniq  >  subversao
                                          valorsubversao=$(<subversao)

                                          echo "75" ; sleep 1
                                          echo "# Instalando o  core, o pacote principal " ; sleep 1 
                                                                                  
                                                if [ -e /usr/bin/dpkg  ]; then
                                                                                  
                                                  sudo -S dpkg -i /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"/"$diretorio"/*  
                                                else
                                                  sudo -S rpm -Uvh /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"/"$diretorio"/*  
                                                fi
                                                                                  
#13                                       ##Instalação do PACOTE DE LINGUAGEM
                                          ##notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Instalando pacotes de idioma!'   
                                                if  ! [  "$idioma" = "en-US" ]
                                                  then
                                                  tar -tzf    "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz |  cut -d '_' -f2  | uniq  >  subversao 
                                                  valorsubversao=$(<subversao)

                                          echo "80" ; sleep 1
                                          echo "# Instalando o pacote de linguagem" ; sleep 1 

                                                  if [ -e /usr/bin/dpkg  ]; then
                                                  sudo -S    dpkg -i /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma"/"$diretorio"/*  
                                                  else
                                                  sudo -S    rpm -Uvh /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma"/"$diretorio"/*  
                                                  fi
                                                           
                                                else 
                                                  exit 1  
                                                fi 
                                                                                  
#14                                       ##PACOTE DE AJUDA
                                          echo "90" ; sleep 1
                                          echo "# Instalando o pacote de ajuda " ; sleep 1 
                                          ##notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Instalando pacotes  de ajuda!'   
                                                tar -tzf    "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz |  cut -d '_' -f2  | uniq  >  subversao 
                                                valorsubversao=$(<subversao)
                                                rm subversao

                                                if [ -e /usr/bin/dpkg  ]; then
                                                    sudo -S  dpkg -i /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma"/"$diretorio"/* 
                                                else
                                                    sudo -S   rpm -Uvh /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma"/"$diretorio"/*  
                                                fi
                                      else
                                      exit 1  
                                      fi  
                                                                                  
#15                                       # Tratando os arquivos utilizados, no momento enviando para um subdiretório do Downloads
                                                                         
                                          echo "100" ; sleep 1
                                          echo "# Instalação concluída " ; sleep 1 

                                      if  [ -n "$(ls -A /opt/libreoffic* )" ]                                                                        
                                            then
                                                notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Instalação concluída !'   
                                      else
                                                notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Não instalado !'
                                      fi  

                                       1 2>/dev/null && exit

                                      ) |      
                                        zenity --progress --pulsate  --width=250 --height=100 \
                                                 --title="Instalado LibreOffice" \
                                                 --text="Iniciando..." \
                                                 --percentage=0

                                            if [ "$?" = -1 ] ; then
                                              zenity --error \
                                                 --text="Instalação cancelada."
                                            fi
                                                              
                                        zenity --question --default-cancel --no-wrap --text 'LibreOffice instalado ! \n Clique em Prosseguir para ativar o monitor de atualização. \n Ou Sair se não quiser ativá-lo' --ok-label="Sair" --cancel-label="OK"
                                            # Sair se pressionou cancelar.
                                              (( $? == 1 )) && 
                        
                                        zenity --question --text="Instalar o Monitor de Atualização" --ok-label="Sim" --cancel-label="Não"
                                                  if [ $? = 0 ] ; then

                                                    if ! [ -e /usr/bin/monitor-libreoffice.sh ]; then   
                                                    sudo -S wget https://raw.githubusercontent.com/ferreirarocha/install-libreoffice/master/monitor-libreoffice.sh -P /usr/bin/
                                                         
                                                    sudo -S chmod +x   /usr/bin/monitor-libreoffice.sh


                                                      crontab -l | grep -q 'bash /usr/bin/monitor-libreoffice.sh'  && echo  '0' > CRON || echo '1' > CRON

                                                        
                                                             if [[ $(cat CRON) == "1" ]]; then 

                                                              (crontab -l ; echo "20 *  * * *     export DISPLAY=:0 && bash /usr/bin/monitor-libreoffice.sh") | crontab -  

                                                            else 
                                                              echo "Já Configurado" 

                                                            fi
                                                     
                                                      


                                                      ; exit 0

                                                    (( $?  )) &&  exit 
                                                    else
                                                        exit 0
                                                    fi     

                                                  else
                                                    exit 0
                                                  fi
                          done                   
                             exit 0                 
                    else
                      exit 0
                    fi
            else                                      
              exit 0            
            fi       
                        
			  else
          exit 0
        fi
   ;;   
    1)
        echo "Instalação Cancelada!"
	;;
    -1)
        echo "Algo inesperado ocorreu."
	;;
esac
