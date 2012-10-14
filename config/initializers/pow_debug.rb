if ENV['ENABLE_REMOTE_DEBUGGER_UNDER_POW'] && Debugger
  Debugger.settings[:autoeval] = true
  Debugger.settings[:autolist] = 1
  Debugger.settings[:reload_source_on_change] = true
  Debugger.start_remote
end
