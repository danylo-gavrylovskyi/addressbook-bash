#!/bin/bash

ADDRESS_BOOK="address_book.txt"

add_contact() {
    read -p "Enter name: " name
    read -p "Enter phone number: " phone
    read -p "Enter email: " email

    echo "$name, $phone, $email" >> "$ADDRESS_BOOK"
    echo "Contact added successfully."
}

search_contact() {
    read -p "Enter search term (name, phone number, email): " term
    echo "Searching for contacts matching '$term'..."
    grep -i "$term" "$ADDRESS_BOOK" || echo "No contacts found."
}

remove_contact() {
    read -p "Enter name, phone number, or email to remove: " term
    term=$(echo "$term" | xargs)

    matches=$(grep -i -F "$term" "$ADDRESS_BOOK")

    if [ -z "$matches" ]; then
        echo "No contacts found."
        return
    fi

    read -p "Are you sure you want to delete these contacts? (y/n): " confirm
    if [[ $confirm == 'y' || $confirm == 'Y' ]]; then
        sed -i "/$term/Id" "$ADDRESS_BOOK"
        echo "Contact(s) removed successfully."
    else
        echo "Operation cancelled."
    fi
}

case $1 in
    add)
        add_contact
        ;;
    search)
        search_contact
        ;;
    remove)
        remove_contact
        ;;
    *)
        echo "Usage: $0 {add|search|remove}"
        ;;
esac

