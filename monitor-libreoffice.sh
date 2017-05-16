
#!/bin/sh -x
#data=date
exec >& >(tee -a /tmp/"$data"-logupdatelibreoffice.txt)
export PATH="/usr/local/sbin:/usr/sbin:/sbin:/bin:/usr/games:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"


#export DISPLAY=0.0

curl http://linorg.usp.br/LibreOffice/libreoffice/stable/ > versao1 
tail -4 versao1  > versao2 
head -1  versao2 > versao3 
cut -d= -f 5   versao3 > versao4 
cat versao4 |  cut -c 2-6 > libreoffice-ultima-versao

/usr/bin/libreoffice* --version > versao-instalada ; cat versao-instalada  | cut -c 12-17 versao-instalada > comparar-versao-instalada 

   sed 's/\.//g' libreoffice-ultima-versao  > UltimaVersao 
   sed 's/\.//g' comparar-versao-instalada  > VersaoLocal 


value=`cat UltimaVersao`
value2=`cat VersaoLocal`

if [ "$value" -gt "$value2" ]; 
	then

               

                    #1 Variável definindo que baixaremos o libreoffice no repositório estável
                    

                    ## Escolhendo a versão do LibreOffice
                    
                    #2 Aqui voĉe pode  inserir  uma lista de seus servidoes preferênciais para baixar o LibreOFfice, com a possiblidies de inserir  um servidor local, ideal para  ambientes  empresariais
                     #Nesse caso utilizei o servidor em minha rede com o IP 192.168.50.122/tdf          

                    
                    #Escolha o servidor para baixar o LibreOffice." 
                    #   "http://tdf.c3sl.ufpr.br"                       "UFPR   "
                    #   "http://linorg.usp.br/LibreOffice"              "USP " 
                    #   "http://ftp.unicamp.br/pub"                     "UNICAMP  " 
                    #   "http://mirror.pop-sc.rnp.br/mirror/tdf"        "PoP-SC "  
                    #   "http://mirror.nexcess.net/tdf"                 "Mirror nexcess" 
                    #   "http://mirror.ufms.br/tdf"                     "Mirror UFMS" 
                    #   "http://tdf.ufes.br/"                           "Mirror UFES" 
                    #   "http://mirror.unesp.br/tdf"                    "Mirror Unesp" 
                    # "192.168.50.122/tdf"                              "Servidor Local "  

                    #                       "Lista de idiomas diposniveis

                    #                       "pt-BR" "Portuguese (Brazil)" 
                    #                       "am"    "Amharic - አማርኛ"
                    #                       "ar"    "Arabic  - العربية  " 
                    #                       "ast"   "Asturian" 
                    #                       "bg"    "Bulgarian (Bulsgaria)  " 
                    #                       "bn-IN" "Bengali, India" 
                    #                       "bn"    "Bengali" 
                    #                       "bo"    "Tibetan Standard - བོད་ཡིག"
                    #                       "bs"    "Bosnian (Bosnia and Herzegovina)" 
                    #                       "ca"    "Catalan" 
                    #                       "cs"    "Czech" 
                    #                       "da"    "Danish" 
                    #                       "de"    "German" 
                    #                       "dz"    "Dzongkha" 
                    #                       "el"    "Greek" 
                    #                       "en-US" "English United Stats" 
                    #                       "en-GB" "English (United Kingdom)" \
                    #                       "en-ZA" "English (South Africa)"
                    #                       "eo"    "Esperanto" 
                    #                       "es"    "Spanish" 
                    #                       "et"    "Estonian" 
                    #                       "eu"    "Basque" 
                    #                       "fi"    "Finnish" 
                    #                       "fr"    "French" 
                    #                       "gl"    "Galician" 
                    #                       "gu"    "Gujarati" 
                    #                       "he"    "Hebrew" 
                    #                       "hi"    "Hindi" 
                    #                       "hr"    "Croatian" 
                    #                       "hu"    "Hungarian" 
                    #                       "id"    "Indonesian" 
                    #                       "is"    "Icelandic" 
                    #                       "it"    "Italian" 
                    #                       "ja"    "Japanese" 
                    #                       "ka"    "Georgian" 
                    #                       "km"    "Khmer" 
                    #                       "ko"    "Korean" 
                    #                       "lo"    "Lao" 
                    #                       "lt"    "Lithuanian" 
                    #                       "lv"    "Latvian" 
                    #                       "mk"    "FYRO Macedonian" 
                    #                       "nb"    "Norwegian (Bokm?l)" 
                    #                       "ne"    "Nepali" 
                    #                       "nl"    "Dutch" 
                    #                       "nn"    "Norwegian Nynorsk" 
                    #                       "om"    "Oromo" 
                    #                       "pl"    "Polish" 
                    #                       "pt"    "Portuguese" 
                    #                       "ro"    "Romanian" 
                    #                       "ru"    "Russian" 
                    #                       "si"    "Sinhala; Sinhalese" 
                    #                       "sid"   "Sidamo" 
                    #                       "sk"    "Slovak" 
                    #                       "sl"    "Slovenian" 
                    #                       "sq"    "Albanian" 
                    #                       "sv"    "Swedish" 
                    #                       "ta"    "Tamil" 
                    #                       "tg"    "Tajik" 
                    #                       "tr"    "Turkish" 
                    #                       "ug"    "Uyghur" 
                    #                       "uk"    "Ukrainian" 
                    #                       "vi"    "Vietnamese (Viet Nam)" 
                    #                       "zh-CN" "Chinese Simplified" 
                    #                       "zh-TW" "Chinese Traditional"  OFF 3>&1 1>&2 2>&3)                          
                    #                       status=$?
        #touch /home/marcos/lixeiratemp           
        /usr/bin/zenity --question --text="A versão "$vs" está disponível, deseja atualizar ?" --ok-label="Sim" --cancel-label="Não"
        #xterm -title 'Atualizar o LibreOffice' -e " read PASSWD ; echo "echo $PASSWD |pwd""


        if [ $? = 0 ]; 
               then
        #        export PATH="/usr/local/sbin:/usr/sbin:/sbin:/bin:/usr/games:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"

                while true
                do
                    resp=$(zenity --password)

                    # Pega a senha do login gráfico
                    senha=$(echo "$resp" | cut -f1 -d'|')

                    # Passa a senha
                    echo $senha | sudo -S -u root zenity --info --text "Vamos começar a instalação" 



                        
                    notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Iniciar Instalação !' 




                    #3 Testando  o gernciador de pacotes"

                            if   [ -e /usr/bin/rpm ]; then
                                    gerenciadorPacote=rpm
                                    diretorio=RPMS
                            else  
                                    gerenciadorPacote=deb
                                    diretorio=DEBS
                            fi

                    #4 Testando  Arquitetura do desktop"

                            if [ `getconf LONG_BIT` = "64" ];
                            then
                                 plafatorma=x86_64
                                 plafatorma2=x86-64
                            else
                                plafatorma=x86
                                plafatorma2=x86
                            fi

                    #5 Escolhendo o idioma local
                    servidor="http://tdf.c3sl.ufpr.br"
                    versaostatus="stable"
                    vs=`cat libreoffice-ultima-versao`
                    idioma="pt-BR"
                       






                 

                
                                                            # Criando diretório para  baixar os pacotes de acordo como versão, gerenciador, arquitetura
                                                            #rm lixeiratemp
                                                            mkdir -m 777 -p "/home/"$USER"/Downloads/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma"" 
                                                            destino="/home/"$USER"/Downloads/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma""   

                    #6                                      #Baixando o LibreOffice
                                                            notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Baixando pacotes !'   

                                                             wget -c "$servidor"/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz  -P "$destino" 

                                                             wget -c "$servidor"/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma".tar.gz   -P "$destino" 

                    #7                                      # Testando se a necessidade de baixar o pacote idioma, no caso do idioma inglÊs não há necessidade. 
                                                            if  ! [  "$idioma" = "en-US" ]
                                                            then
                                                            wget -c "$servidor"/libreoffice/"$versaostatus"/"$vs"/"$gerenciadorPacote"/"$plafatorma"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma".tar.gz   -P "$destino" 
                                                            else 
                                                            exit 1   
                                                            fi

                    #8                                          #Testando se o pacote Core do LibreOffice foi instalado para dar continuidade ao processso, caso afirmativo ocorre um teste de gerenciador de pacotes para desinstalar a verão anterior do LO. 
                                                                 notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Removendo versão anterior '$comparar-versao-instalada'. !'      
                                                                if  [ -e "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz ]
                                                                    then
                                                                     if [ -e /usr/bin/yum  ]; then
                                                                      sudo -S  yum remove openoffice[0-9]* libreoffice[0-9]* -y

                                                                     elif [ -e /usr/bin/zypper  ]; then
                                                                      sudo -S  zypper -n remove libreoffice[0-9]*
                                                                    
                                                                    elif [ -e /usr/bin/zypper ]; then
                                                                      sudo -S zypper -n remove openoffice[0-0]*

                                                                     elif [ -e /usr/bin/dpkg  ]; then
                                                                     sudo -S  apt-get remove --purge libreoffice[0-9]* -y  

                                                                    else
                                                                        exit 1  
                                                                    fi
                                                                     
                    # 9                                             # Descompactando os pacotes Libre Office
                                                                       notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Extraindo pacotes !'         

                                                                        tar -xzf  "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz  -C /tmp 
                                                                    
                    #10                                             # Testando a necessidade de instalar Pacote de Idioma
                                                                    if  ! [  "$idioma" = "en-US" ]
                                                                    then
                                                                        tar -xzf  "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma".tar.gz   -C /tmp 
                                                                    else 
                                                                         exit 1  
                                                                    fi
                                                                    
                    #11                                             # Instalação do Pacote de Ajuda
                                                                        tar -xzf   "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma".tar.gz  -C /tmp 

                                                                    # Aqui ocorre a instalação do pacote principal do Libre Office
                                                                    
                    #12                                             #PACOTE ACORE
                                                                    notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Instalando pacotes principal!'   
                                                                   tar -tzf    "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz |  cut -d '_' -f2  | uniq  >  subversao
                                                                    valorsubversao=$(<subversao)
                                                                    
                                                                        if [ -e /usr/bin/dpkg  ]; then
                                                                       sudo -S dpkg -i /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"/"$diretorio"/*  
                                                                        else
                                                                       sudo -S rpm -Uvh /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"/"$diretorio"/*  
                                                                        fi
                                                                    
                    #13                                             ##Instalação do PACOTE DE LINGUAGEM

                                                                    notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Instalando pacotes de idioma!'   
                                                                    if  ! [  "$idioma" = "en-US" ]
                                                                    then
                                                                        tar -tzf    "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz |  cut -d '_' -f2  | uniq  >  subversao 
                                                                        valorsubversao=$(<subversao)

                                                                            if [ -e /usr/bin/dpkg  ]; then
                                                                        sudo -S    dpkg -i /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma"/"$diretorio"/*  
                                                                            else
                                                                        sudo -S    rpm -Uvh /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_langpack_"$idioma"/"$diretorio"/*  
                                                                            fi
                                                                    
                                                                    else 
                                                                         exit 1  
                                                                    fi 
                                                                    
                    #14                                             ##PACOTE DE AJUDA
                                                                    notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Instalando pacotes  de ajuda!'   
                                                                   tar -tzf    "$destino"/LibreOffice_"$vs"_Linux_"$plafatorma2"_"$gerenciadorPacote".tar.gz |  cut -d '_' -f2  | uniq  >  subversao 
                                                                    valorsubversao=$(<subversao)


                                                                        if [ -e /usr/bin/dpkg  ]; then
                                                                     sudo -S  dpkg -i /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma"/"$diretorio"/* 
                                                                        else
                                                                     sudo -S   rpm -Uvh /tmp/LibreOffice_"$valorsubversao"_Linux_"$plafatorma2"_"$gerenciadorPacote"_helppack_"$idioma"/"$diretorio"/*  
                                                                        fi
                                                            else
                                                                    exit 1  
                                                            fi  
                    #15                         # Tratando os arquivos utilizados, no momento enviando para um subdiretório do Downloads
                                                             rm subversao


                                                            if  [ -n "$(ls -A /opt/libreoffic* )" ]
                                                                
                                                                then
                                                                    notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Instalação concluída !'   
                                                            else

                                                                     notify-send -i libreoffice -t 50000 'LibreOffice '$vs'' 'Não instalado !'

                                                            fi  

                                                            1 2>/dev/null && exit

                                     # Perguntar se quer tentar novamente.
                                        zenity --question --text 'Sucesso. Tentar novamente?'

                                        # Sair se pressionou cancelar.
                                        (( $? )) && exit
                                    
                         done

                         #EOF                                       

       else
           exit 1
       fi
        
else 
    echo "você tem a versão mais atual" > /var/log/backup.log
fi
