
#!/bin/sh
#data=date
exec >& >(tee -a /tmp/"$data"-logupdatelibreoffice.txt)
export PATH="/usr/local/sbin:/usr/sbin:/sbin:/bin:/usr/games:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"


#export DISPLAY=0.0

curl http://linorg.usp.br/LibreOffice/libreoffice/stable/ > /tmp/versao1 
tail -4 /tmp/versao1  > /tmp/versao2 
head -1  /tmp/versao2 > /tmp/versao3 
cut -d= -f 5   /tmp/versao3 > /tmp/versao4 
cat /tmp/versao4 |  cut -c 2-6 > /tmp/libreoffice-ultima-versao

/usr/bin/libreoffice* --version > /tmp/versao-instalada ; cat /tmp/versao-instalada  | cut -c 12-17 /tmp/versao-instalada > /tmp/comparar-versao-instalada 

   sed 's/\.//g' /tmp/libreoffice-ultima-versao  > /tmp/UltimaVersao 
   sed 's/\.//g' /tmp/comparar-versao-instalada  > /tmp/VersaoLocal 


value=`cat /tmp/UltimaVersao`
value2=`cat /tmp/VersaoLocal`

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
                    servidor="192.168.0.187/tdf"
                    versaostatus="stable"
                    vs=`cat /tmp/libreoffice-ultima-versao`
                    idioma="pt-BR"
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
                if [-e /usr/bin/dnf ]; then      
                    xterm  -e "bash /usr/bin/instalador-libreoffice.sh"	&&  zenity --info --title "Atualização" --width=200 --height=100  --text  'O LibreOffice foi atualizado com sucesso clique em OK para saír'
                elif [-e /usr/bin/zypper ]; then
                    xterm  -e "sudo bash /usr/bin/instalador-libreoffice.sh"	&&  zenity --info --title "Atualização" --width=200 --height=100  --text  'O LibreOffice foi atualizado com sucesso clique em OK para saír'
                else
                    xterm  -e "sudo bash /usr/bin/instalador-libreoffice.sh"	&&  zenity --info --title "Atualização" --width=200 --height=100  --text  'O LibreOffice foi atualizado com sucesso clique em OK para saír'
                fi
       else
           exit 1
       fi
        
else 
    echo "você tem a versão mais atual" > /var/log/backup.log
fi
