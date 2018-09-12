$(document).ready(function () {
    initChart();
});

function initChart() {
    new Chartkick.ColumnChart("stock_chart", stockCalculations(), {xtitle: 'Year', ytitle: 'Balance'});
}

function stockCalculations() {
    const stockData = $('#stock_data').data('stock');
    const duration = stockData.duration;
    const price = stockData.price;
    const interest = stockData.interest / 100;
    const compoundedPerYear = 12;
    let chartData = Array.from({length: duration}, function (v, year) {
        year++;
        let balance = price * Math.pow(1 + interest / compoundedPerYear, compoundedPerYear * year);
        balance = Math.round(balance * 100) / 100;
        return [year, balance];
    });
    return chartData;
}
