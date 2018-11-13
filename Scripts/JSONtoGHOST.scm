(use-modules (ice-9 hash-table))
(use-modules (json))

(define port (open-input-file "1.json"))
(define output-port (open-file "1.ghost" "a"))
(define hashy (json->scm port))

(define linenum 1)
(define emote '("worry" "happySurprise" "happy.001" "recoil" "happyDisgust" "happy" "surprisedSad" "surprised" "sad" "irritated" "happy.002" "fearSuprise" "fear" "engaged" "disgustSurprise" "disgust.Sad" "disgust" "contempt" "confused" "comprehending" "bored" "awe" "angrySad" "angryDisgust" "angry" "amused" "none"))
(for-each (lambda(ele) (display "u: RULE" output-port) (display linenum output-port) (display "() " output-port) (set! linenum (1+ linenum)) 
	(display ele)
	(display (hash-count (const #t) ele))
	(if (hash-get-handle ele "gesture")
		(begin
			(display "^gesture(" output-port)
			(display (cdr(hash-get-handle ele "gesture")))
			(display (cdr(hash-get-handle ele "gesture")) output-port)
			(if (member (cdr(hash-get-handle ele "gesture")) emote)
				;;emote(name_node, magnitude_node, duration_node, blend_node)
				(begin
					(display ", " output-port)
					(display (cadr(hash-get-handle ele "magnitude")) output-port)
					(display ", " output-port)
					(display (cdr(hash-get-handle ele "duration")) output-port)
					;;(display ", 1)" output-port)
				)
				;;gesture(name_node, speed_node, magnitude_node, repeat_node)
				(begin
					(display ", " output-port)
					(display (cdr(hash-get-handle ele "speed")) output-port)
					(display ", " output-port)
					(display (cadr(hash-get-handle ele "magnitude")) output-port)
				)					
			)
			;;blend or repeat value
			(display ", 1)" output-port)
		)
		#t
	)

(hash-for-each (lambda (key value)
	(begin
		(if (equal? key "start_time")
			(begin
				(display "^start_timer(" output-port)
				(display value output-port)
				(display ") " output-port)
			)
			#t
		)
		(if (equal? key "text")
			(begin
				(display value output-port)
				(display " " output-port)
			)
			#t
		)
	)) 
	ele) (display "\n" output-port)) hashy)
(close port)
(close output-port)