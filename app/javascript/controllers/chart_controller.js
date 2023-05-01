import { Controller } from "@hotwired/stimulus"

import Chart from 'chart.js/auto';

// Connects to data-controller="chart"
export default class extends Controller {
  connect() {

    const ctx = document.getElementById('myChart');
    const dataValue = [
      this.element.dataset.regular,
      this.element.dataset.rd,
      this.element.dataset.bd,
      this.element.dataset.wd,
    ];
    
    const chart = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: ['一般會員', '白鑽會員', '藍鑽會員', '紅鑽會員'],
        datasets: [{
          label: '總人數：',
          data: dataValue,
          borderWidth: 1,
          backgroundColor: [
            'rgba(185, 246, 156)',
            'rgba(254, 239, 146)',
            'rgba(136, 240, 240)',
            'rgba(246, 208, 216)',
          ]
        }]
      },
      options: {
        maintainAspectRatio: false,
      }
    });
  }
}