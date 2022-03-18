import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['searchKey', 'form']

  get searchKey() {
    return this.searchKeyTarget;
  }

  get form() {
    return this.formTarget;
  }

  initialize() {
    console.log('Hello from stimulus!');
  }

  detach(element) {
    return element.parentElement.removeChild(element);
  }

  move(src, dest) {
    let element = this.detach(src);
    dest.insertAdjacentElement('beforebegin', element);
  }

  row(table, index) {
    let tableBody = table.querySelector('tbody');
    return tableBody.querySelector(`tr:nth-child(${index})`);
  }

  moveRow(table, fromIndex, toIndex) {
    let fromRow = this.row(table, fromIndex);
    let toRow = this.row(table, toIndex);
    this.move(fromRow, toRow);
  }

  searchKeyValidation(event) {
    let table = document.querySelector('table');
    let searchKeyText = this.searchKey.value;
    let rowIndex;

    Array.from(table.rows).filter(function(item, index) {
      let condition = item.cells[0].innerHTML === searchKeyText;

      if (condition) {
        rowIndex = index;
        return condition;
      }
    })

    if (rowIndex !== undefined) {
      this.stopFormSubmit(event);
      this.moveRow(table, rowIndex, 1);
    }
  }

  stopFormSubmit(event) {
    event.preventDefault();
    event.stopPropagation();
  }
}
