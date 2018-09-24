(use-modules (ice-9 rdelim))
(use-modules (ice-9 textual-ports))

;; TODO: HANDLING GESTURE AND EMOTION RULES
;; TODO: TESTING
;; TODO: RUNNING THIS ON LOOP FOR ALL TIMELINE STORIES 
;; TODO: ADDING COMMENTS / MAKING IT MORE READABLE

(let ((input-port (open-input-file "1.json")) (output-port (open-file "1.ghost" "a")))
	(define keyval "start here")
	(define linenum 1)
	(do ((line (read-line input-port) (read-line input-port))) ((eof-object? line))
		(if (= (string-length line) 1)
			(begin
				(display "u: RULE" output-port) 
				(display linenum output-port)
				(set! linenum (1+ linenum))
				(display "()\n" output-port)
			)
			(begin
				(set! line (string-trim-right line #\,))
				(set! keyval (string-split (string-trim-both line) #\:))
				(if (equal? (car keyval) "\"start_time\"")
					(begin
						(display "^" output-port)
						(display "start_timer" output-port)
						(display (cdr keyval) output-port)
						(display "\n" output-port)
					)
					(display "\n") ;; continue	
				)
				(if (equal? (car keyval) "\"text\"")
					(begin
						(display (cdr keyval) output-port)
						(display "\n" output-port)
					)
					(display "\n") ;; continue
				)
			)
		)
	)
	(close input-port)
	(close output-port))