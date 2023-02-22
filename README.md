## custom_date_range_picker

**custom_date_range_picker**

<p align="center"><img src="https://raw.githubusercontent.com/sumitkakshapati/custom_date_range_picker/master/screenshot_ad_mode.png" width="320" height="650"/></p>

<p align="center"><img src="https://raw.githubusercontent.com/sumitkakshapati/custom_date_range_picker/master/screenshot_bs_mode.png" width="320" height="650"/></p>

To call the CustomDateRangePicker component, you need to pass the following props:

```dart
...
  floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomDateRangePicker(
            context,
            dismissible: true,
            endDate: endDate,
            startDate: startDate,
            calenderType: CalenderType.AD,
            onApplyClick: (rangeDate) {
              type = rangeDate.type;
              endDate = rangeDate.endDateInAD;
              startDate = rangeDate.startDateInAD;
            },
          );
        },
        tooltip: 'choose date Range',
        child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
      ),
```
