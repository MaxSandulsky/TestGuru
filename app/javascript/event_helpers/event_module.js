import {Sorter} from "utilities/sorting"
import {Comparator} from "utilities/password_match"

export const enable_inputCompare_for = (element_class) => {
  const control = document.querySelectorAll(element_class)

  if (control) {
    control.forEach(element => {
      element.addEventListener('input', () => {
        const comparing_field = new Comparator
        comparing_field.comparePasswords()
      })
    })
  }
}


export const enable_tableSort_for = (element_class) => {
  const control = document.querySelectorAll(element_class)

  if (control) {
    control.forEach(element => {
      element.addEventListener('click', () => {
        const sortingTable = new Sorter(element)
        sortingTable.sortRowsbyColumn()
      })
    })
  }
}