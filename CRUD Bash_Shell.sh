users_name=()
users_password=()
planet_names=()
planet_sizes=()
planet_mass=()

function start(){
    clear
    echo "Hello, user"
    echo "Press 1. if you want to register!"
    echo "Press 2. if you want to login!"
    echo "Press 3. if you want to exit!"
    read -p "Enter: " choice
    case $choice in
        1) register_user;;
        2) login_user;;
        3) exit;;
    esac
}
function register_user(){
    clear
    echo "-------REGISTRATION FORM----------"
    echo "Please register: "
    read -p "Name:" name
    read -p "Password:" password
    var_check=false
    if [[ "$name" -eq 0 && "$password" -eq 0 ]]; then
        echo "Invalid enter"
        var_check=false
    else
        var_check=true
        #Dodavanje korisnika u nizove
        users_name+=("$name")
        users_password+=("$password")
        read -p "Succesfull registration. For login press enter"
        login_user
    fi
}
function login_user(){
    clear
    echo "------------LOGIN FORM-----------"
    echo "Please enter your name and password. "
    read -p "Name:" name
    read -p "Password:" password
    
    var_found=false
    for (( i=0; i<${#users_name[@]}; i++ )); do
        if [[ "${users_name[i]}" == "$name" && "${users_password[i]}" == "$password" ]]; then
            var_found=true
            break
        fi
    done
    
    if [[ $var_found == true ]]; then
        read -p "Login successful. For start press ENTER"
        main_menu
    else
        echo "Wrong name or password."
        echo "For try again enter 1."
        echo "For registration enter 2."
        read -p "Enter choice: " choice
        case $choice in
            1) login_user;;
            2) register_user;;
            *) echo "Invalid choice";;
        esac
    fi
}
function main_menu(){
    clear
    echo "=====Main Menu======"
    echo "Press 1. for planet add"
    echo "Press 2. for planet show"
    echo "Press 3. for planet update"
    echo "Press 4. for planet delete"
    echo "Press 5. exit program"
    read -p "Choose option: " choice
    case $choice in
        1) add_planet;;
        2) show_planet;;
        3) planet_update;;
        4) planet_delete;;
        5) exit;;
        *) echo "Invalid enter. Please enter again.";;
    esac
}
function add_planet(){
    clear
    echo "Add a new planet"
    read -p "Enter name: " name
    read -p "Enter mass: " mass
    read -p "Enter size: " size
    
    #adding data to arrays
    planet_names+=("$name")
    planet_mass+=("$mass")
    planet_sizes+=("$size")
    
    echo "New planet /$name/ is successfully added"
    read -p "Press enter for main menu"
    main_menu
}
function show_planet(){
    clear
    echo "-----LIST OF PLANETS-------"
    if [[ ${#planet_names[@]} -eq 0 ]]; then
        read -p "List is empty! For main menu press ENTER"
        main_menu
    else
        for (( i=0; i<${#planet_names[@]}; i++ )); do
            echo "Planeta $((i+1)): "
            echo "Ime planete: ${planet_names[i]}"
            echo "Masa planete: ${planet_mass[i]}"
            echo "Size of planet: ${planet_sizes[i]}"
        done
    fi
    read -p "Press ENTER for main menu"
    main_menu
}
function planet_update(){
    clear
    planet_found=false
    echo "-----PLANET UPDATE-----"
    if [[ ${#planet_names[@]} -eq 0 ]]; then
        echo "Nema dodanih planeta!, molimo dodajte pa pokusajte ponovo!"
        read -p "For main menu press ENTER"
        main_menu
        return
    fi
    read -p "Enter name of planet to update" name_planet
    for (( i=0; i<${#planet_names[@]}; i++ )); do
        if [[ "${planet_names[i]}" == *"$name_planet"* ]]; then
        planet_found=true
            echo "Unesi nove podatke:"
            read -p "Unesi novo ime planete: " new_name
            read -p "Unesi novu masu planete: " new_mass
            read -p "Unesi novu velicinu planete: " new_size
            #azuriranje podataka o novoj planet_sizes
            planet_names[i]=$new_name
            planet_mass[i]=$new_mass
            planet_sizes[i]=$new_size
            
            echo "Podaci o planeti $name_planet su uspjesno azurirani"
            break
        fi
    done
    
    if [[ $planet_found == false ]]; then
        echo "Planeta sa imenom: $name_planet nije pronadjena."
    fi
    read -p "Press ENTER for main menu"
    main_menu
    
}

function planet_delete(){
    clear
    echo "----BRISANJE PLANETE----"
    planet_found=false
    read -p "Unesi ime planete za brisanje: " ime_planete
    for (( i=0; i<${#planet_names[@]}; i++ )); do
        if [[ "${planet_names[i]}" == "$ime_planete" ]]; then
            unset "planet_names[i]"
            unset "planet_mass[i]"
            unset "planet_sizes[i]"
            planet_found=true
            echo "Planeta: $ime_planete uspjesno izbrisana!"
            break
        fi
    done
    if [[ $planet_found == false ]]; then
        echo "Planeta sa imenom: $ime_planete nije pronadjena!"
    fi
    read -p "Za povratak u meni stisni ENTER"
    main_menu
}
#start program
start