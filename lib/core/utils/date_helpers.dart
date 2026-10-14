// lib/core/utils/date_helpers.dart

class DateHelpers {
  // Returns 0 for Monday, 1 for Tuesday, ..., 6 for Sunday
  static int get currentWeekdayIndex {
    return DateTime.now().weekday - 1; // DateTime.weekday is 1-based (1=Monday, 7=Sunday)
  }

  // Returns the full name of today (e.g., "Monday", "Tuesday", ..., "Sunday")
  static String get todayDayName {
    const daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return daysOfWeek[currentWeekdayIndex];
  }

  // Returns formatted string like "Wednesday, Oct 14"
  static String get formattedTodayDate {
    final now = DateTime.now();
    final day = now.day;
    final month = now.month;
    const monthName = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '$todayDayName, ${monthName[month - 1]} $day';
  }

  // Returns "Good Morning," (5am–12pm), "Good Afternoon," (12pm–5pm), or "Good Evening," (5pm–5am)
  static String get timeOfDayGreeting {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning,';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  // Helper returning the default split focus string based on day index
  static String getDayFocus(int dayIndex) {
    const dayFocuses = [
      'CORE & STABILITY',
      'CHEST & TRICEPS',
      'BACK & BICEPS',
      'LEGS & GLUTES',
      'UPPER BODY POWER',
      'CONDITIONING & ABS',
      'ACTIVE RECOVERY'
    ];
    return dayFocuses[dayIndex % dayFocuses.length]; // Ensure dayIndex is within bounds
  }
}
