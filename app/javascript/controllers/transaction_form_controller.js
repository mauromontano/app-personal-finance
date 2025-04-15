import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["amount", "typeTab"]

  connect() {
    // Set default date to today
    const dateInput = this.element.querySelector('input[type="date"]')
    if (dateInput) {
      dateInput.valueAsDate = new Date()
    }

    // Add hidden field for transaction_type
    const hiddenTypeInput = document.createElement('input')
    hiddenTypeInput.type = 'hidden'
    hiddenTypeInput.name = 'transaction[transaction_type]'
    this.element.appendChild(hiddenTypeInput)

    // Initialize tabs
    this.typeTabTargets.forEach(tab => {
      tab.addEventListener('click', () => this.switchType(tab))
      if (tab.dataset.type === 'expense') {
        this.activateTab(tab)
        hiddenTypeInput.value = 'expense'
      } else {
        this.deactivateTab(tab)
      }
    })
  }

  switchType(selectedTab) {
    const hiddenTypeInput = this.element.querySelector('input[name="transaction[transaction_type]"]')
    hiddenTypeInput.value = selectedTab.dataset.type

    this.typeTabTargets.forEach(tab => {
      if (tab === selectedTab) {
        this.activateTab(tab)
      } else {
        this.deactivateTab(tab)
      }
    })
  }

  activateTab(tab) {
    const activeClasses = tab.dataset.activeClasses.split(' ')
    const defaultClasses = tab.dataset.defaultClasses.split(' ')
    
    tab.classList.remove(...defaultClasses)
    tab.classList.add(...activeClasses)
  }

  deactivateTab(tab) {
    const activeClasses = tab.dataset.activeClasses.split(' ')
    const defaultClasses = tab.dataset.defaultClasses.split(' ')
    
    tab.classList.remove(...activeClasses)
    tab.classList.add(...defaultClasses)
  }

  submitForm(event) {
    event.preventDefault()
    
    const amount = parseFloat(this.amountTarget.value)
    if (!amount) return

    const activeTab = this.typeTabTargets.find(tab => 
      tab.classList.contains('bg-emerald-600')
    )
    
    // Adjust amount sign based on transaction type
    this.amountTarget.value = activeTab.dataset.type === 'expense' 
      ? -Math.abs(amount) 
      : Math.abs(amount)

    this.element.submit()
  }
} 