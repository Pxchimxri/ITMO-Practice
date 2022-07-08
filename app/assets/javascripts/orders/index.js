$(document).ready(() => {
    let allOrdersFilter = $('#all_orders_filter');
    let statusFilters = $('.status_filter');

    allOrdersFilter.on('click', () => {
        allOrdersFilter.prop('disabled', true);
        statusFilters.prop('checked', true).change();
    });

    statusFilters.on('click', () => {
        if (statusFilters.filter(':checked').length === statusFilters.length) {
            allOrdersFilter.prop('disabled', true).prop('checked', true);
        } else {
            allOrdersFilter.prop('disabled', false).prop('checked', false);
        }
    });

    $('.allow-focus').on('click', e => {
        e.stopPropagation();
    });
});
