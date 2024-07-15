import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "sourceAccount",
    "destinationAccount",
    "transactionType",
    "category",
  ];

  connect() {
    this.toggleAccountFields();
  }

  toggleAccountFields() {
    const transactionType = this.transactionTypeTarget.value;

    this.categoryTarget.style.display = "none";

    if (transactionType === "Transactions::Expense") {
      this.sourceAccountTarget.style.display = "";
      this.destinationAccountTarget.style.display = "none";

      this.categoryTarget.style.display = "";
    } else if (transactionType === "Transactions::Income") {
      this.sourceAccountTarget.style.display = "none";
      this.destinationAccountTarget.style.display = "";
    } else if (transactionType === "Transactions::Transfer") {
      this.sourceAccountTarget.style.display = "";
      this.destinationAccountTarget.style.display = "";
    } else {
      this.sourceAccountTarget.style.display = "none";
      this.destinationAccountTarget.style.display = "none";
    }
  }
}
