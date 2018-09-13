$(document).ready(function () {
    initChart();
});

function initChart() {
    new Chartkick.ColumnChart("stock_chart", stockCalculations(), {xtitle: 'Year', ytitle: 'Balance'});
}

function stockCalculations() {
    var stockData = $('#stock_data').data('stock');
    var duration = stockData.duration;
    var interest = stockData.interest / 100;
    var price = stockData.price;
    var compoundedPerYear = 12;
    var chartData = Array.from({length: duration}, function (v, year) {
        year++;
        var balance = price * Math.pow(1 + interest / compoundedPerYear, compoundedPerYear * year);
        balance = Math.round(balance * 100) / 100;
        return [year, balance];
    });
    return chartData;
}
