#!/usr/bin/sbcl --script

(let ((*standard-output* (make-broadcast-stream))
      (quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(let ((*standard-output* (make-broadcast-stream)))
  (ql:quickload :jsown)
  (ql:quickload :external-program))

(defconstant *debug* t)

(defconstant *log-file* (merge-pathnames
                         ".i3/status-log"
                         (user-homedir-pathname)))

(defun input-json (stream)
  (let ((str (read-line stream nil nil t)))
    (if (eq #\} (char str (1- (length str))))
        str
        (concatenate 'string str (input-json stream)))))

(defun handle-input (input)
  (let ((name (jsown:val (jsown:parse input) "name")))
    (cond ((equalp name "tztime")
           (external-program:start "/usr/bin/gsimplecal" nil)))))

(defun run ()
  (let ((json (input-json *standard-input*)))
    (if *debug*
        (with-open-file (stream *log-file*
				:direction :output
        :if-does-not-exist :create
				:if-exists :append)
          (format stream "~a~%" json)))
    (handle-input (string-trim ",[" json))))

(external-program:start
 (merge-pathnames ".i3/net-speed" (user-homedir-pathname))
 nil
 :output t)

(loop
   (run))
