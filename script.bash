#!/usr/bin/env bash

# task 1:
task1(){
    echo $(cat /etc/passwd)
}

# task 2:
task2(){
    x=$@
    if ! [[ $x =~ ^[0-9]+$ ]]; then
        echo "x is not a number"
        exit
    fi

    if [[ $x -gt 10 ]]; then
        echo "x is greater than 10"
    fi

    if [[ $x -lt 10 ]]; then
        echo "x is less than 10"
    fi

    if [[ $x = 10 ]]; then
        echo "x is 10"
    fi
}

# tash 3: checking if user is a root
task3(){
    if ! [[ $EUID = 0 ]]; then
        echo "You are not a root"
        exit
    fi
}

task5(){
    ips=("127.0.0.1" "8.8.8.8" "1.1.1.1")
    for ip in ${ips[*]}; do
        ping -c 3 "${ip}"
    done
}

task6(){
    echo $(hostname)
    echo $(date)
    echo $(hostname -I)
}

task7(){
    options=("Hello" "Random" "Delete")
    echo "Please choose one of the options below"
    i=0
    for option in ${options[*]}; do
        i=$((i+1))
        echo "[$i] ${option}"
    done
    echo -n "Select option: "
    read option
    if [[ $option = 1 ]]; then
        echo "Hello"
    fi

    if [[ $option = 2 ]]; then
        strings=qwertyuiopasdfghjklzxcvbnm
        for i in {5..20}; do
            echo -n "${strings:RANDOM%${#strings}:1}"
        done
        echo
    fi

    if [[ $option = 3 ]]; then
        fileName = `basename "$0"`
        rm -rf fileName
    fi

}

task8(){
    fileName=$(tr -dc a-zA-Z0-9 </dev/urandom | head -c 10)
    fileExts=(".php" ".html" ".bash" ".js" ".txt" ".pdf" ".go" ".c++" "" ".docx" ".xls" ".json" ".cfg" ".c" ".conf" ".sql" ".db")
    ext=${fileExts[$RANDOM % ${#fileExts[@]}]}
    content=$(tr -dc a-zA-Z0-9 </dev/urandom | head -c $(($RANDOM % 20)))

    echo $content > $fileName$ext
}

uPassword=$@
task9(){
    password="Sup3rPass_word92"
    if [ $uPassword == $password ]; then
        echo Welcome
    else
        echo bye
    fi
}

task10(){
    userName="userst"
    userPass="sTr3su!2"
    useradd $userName
    echo $userName:$userPass | chpasswd
}


path=$@
task13(){
    if [ -f "$path" ]; then
        echo "file exists"
    else
        echo "file does not exist"
    fi
}

path=$1
task14(){
    if [ -f "$path" ]; then
        search=$(cat "$path" | grep -c "root")
        if [ $search -gt 0 ]; then
            echo true
        fi
    fi
}

times=$1
printText=$2
task15(){
    for ((i=1; i <= $times; i++)); do
        echo $printText
    done
}

word=$1
task16(){
    for letter in $(seq 1 ${#word}); do
        echo "${word:letter-1:1}"
        sleep 1
    done
}

task17(){
    # run system update
    # install and run apache2
    # echo 404 > index.html
    # curl localhost/index.html
    # Checking if the user is a root
    task3
    # After we know that the user is root, we can execute commands
    echo "[+] Syncing the database, please wait..."
    apt update &> /dev/null
    echo "[+] Sync complete"
    echo "[+] Installing apache2 server, please wait..."
    apt install -y apache2 &> /dev/null
    echo "[+] Apache2 installation complete, launching apache2 server..."
    systemctl start apache2 &> /dev/null
    echo "[+] Apache2 server started"
    echo "[+] Rewriting the content of index.html file"
    echo 404 > index.html
    curl http://localhost/index.html
}
task17