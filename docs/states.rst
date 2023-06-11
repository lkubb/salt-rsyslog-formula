Available states
----------------

The following states are found in this formula:

.. contents::
   :local:


``rsyslog``
^^^^^^^^^^^
*Meta-state*.

This installs the rsyslog package,
manages the rsyslog configuration file
and then starts the associated rsyslog service.


``rsyslog.package``
^^^^^^^^^^^^^^^^^^^
Installs the rsyslog package only.


``rsyslog.config``
^^^^^^^^^^^^^^^^^^
Manages the rsyslog service configuration.
Has a dependency on `rsyslog.package`_.


``rsyslog.service``
^^^^^^^^^^^^^^^^^^^
Starts the rsyslog service and enables it at boot time.
Has a dependency on `rsyslog.config`_.


``rsyslog.clean``
^^^^^^^^^^^^^^^^^
*Meta-state*.

Undoes everything performed in the ``rsyslog`` meta-state
in reverse order, i.e.
stops the service,
removes the configuration file and then
uninstalls the package.


``rsyslog.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^
Removes the rsyslog package.
Has a dependency on `rsyslog.config.clean`_.


``rsyslog.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^
Removes the configuration of the rsyslog service and has a
dependency on `rsyslog.service.clean`_.


``rsyslog.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^
Stops the rsyslog service and disables it at boot time.


