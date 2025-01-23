age_enc() {
  age -e -i ~/.age.key -r $(age-keygen -y ~/.age.key) -o "$1".age $1
}

age_dec() {
  age -d -i ~/.age.key -o "$1" $1.age
}