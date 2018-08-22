(defun move_wind1()
  "move to up left window"
  (interactive)
  (ignore-errors (windmove-up))
  (ignore-errors (windmove-left))
  (ignore-errors (windmove-up))
  )

(defun move_wind2()
  "move to up left window"
  (interactive)
  (ignore-errors (windmove-up))
  (ignore-errors (windmove-right))
  (ignore-errors (windmove-up))
  )

(defun move_wind3()
  "move to up left window"
  (interactive)
  (ignore-errors (windmove-down))
  (ignore-errors (windmove-left))
  (ignore-errors (windmove-down))
  )

(defun move_wind4()
  "move to up left window"
  (interactive)
  (ignore-errors (windmove-down))
  (ignore-errors (windmove-right))
  (ignore-errors (windmove-down))
  )

(provide 'win_move)
