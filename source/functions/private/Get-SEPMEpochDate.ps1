Function Get-SEPMEpochDate ($epochDate) { [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddMilliseconds($epochDate)) }