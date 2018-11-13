(use-modules (ice-9 hash-table))
(use-modules (json))
(use-modules (ice-9 rdelim))

(define yaml (open-input-file "1.yaml"))
(define json (open-output-file "1.json"))
(define firstline 1)

(do ((line (read-line yaml) 
	(read-line yaml))) ((eof-object? line))
	(if (string-match "nodes:" line)
		(display "[\n" json)
		(if (string-match "- magnitude:" line)
			(begin
				(if (= firstline 1)
						(begin
							(set! firstline 0)
						)
						(begin
							(display "\n}\n" json)
						)
				)
				(display "{\n\t\"magnitude\": [" json)
				(set! line (read-line yaml))
				(set! line (string-trim-both (string-trim (substring line 2 (string-length line))) #\-))
				(display line json)
				(display ", " json)
				(set! line (read-line yaml))
				(set! line (string-trim-both (string-trim (substring line 2 (string-length line))) #\-))
				(display line json)
				(display "]" json)
			)
			(if (string-match "-+ [a-z]*:" line)
				(begin
					(if (= firstline 1)
						(begin
							(set! firstline 0)
						)
						(begin
							(display "\n}\n" json)
						)
					)
					(display "{\n\t\"" json)
					(set! line (string-trim-both line))
					(set! line (string-trim-both line #\-))
					(set! line (string-split line #\:))
					(display (string-trim (car line)) json)
					(display "\": " json)
					(display (substring (object->string (cdr line)) 1 (1- (string-length (object->string (cdr line))))) json)
				)
				(if (string-match "magnitude:" line)
					(begin
						(display ",\n\t\"magnitude\": [" json)
						(set! line (read-line yaml))
						(set! line (string-trim-both (string-trim (substring line 2 (string-length line))) #\-))
						(display line json)
						(display ", " json)
						(set! line (read-line yaml))
						(set! line (string-trim-both (string-trim (substring line 2 (string-length line))) #\-))
						(display line json)
						(display "]" json)
					)
					(if (string-match "text:" line)
						(begin
							(if (string-match ">" line)
								(begin
									(set! line (read-line yaml))
									(display ",\n\t\"text\": \"" json)
									(set! line (string-trim-both line))
									(string-for-each-index (lambda (i) 
										(if (equal? (string-ref line i) #\>) #t
											(if (equal? (string-ref line i) #\<) #t
												(if (equal? (string-ref line i) #\=) #t 
													(if (equal? (string-ref line i) #\/) #t 
														(if (equal? (string-ref line i) #\") #t  
															(begin
																(display (string-ref line i) json)
															)
														)
													)
												)
											)
										)) line
									)
									(display "\"" json)
								)
								(begin
									(display ",\n\t\"" json)
									(set! line (string-split line #\:))
									(display (string-trim (car line)) json)
									(display "\": " json)
									(display (substring (object->string (cdr line)) 1 (1- (string-length (object->string (cdr line))))) json)
								)
							)
						)
						(begin
							(if (string-match ":" line)
								(begin
									(display ",\n\t\"" json)
									(set! line (string-trim-both line))
									(set! line (string-trim-both line #\-))
									(set! line (string-split line #\:))
									(display (string-trim (car line)) json)
									(display "\": " json)
									(display (substring (object->string (cdr line)) 1 (1- (string-length (object->string (cdr line))))) json)
								)
								#t
							)	
						)
					)	
				)
			)
		)		
	)	
)

(display "\n}\n]" json)

(close yaml)
(close json)