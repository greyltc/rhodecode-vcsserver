
==============================
 Generate the Nix expressions
==============================

Details can be found in the repository of `RhodeCode Enterprise CE`_ inside of
the file `docs/contributing/dependencies.rst`.

Start the environment as follows:

.. code:: shell

   nix-shell pkgs/shell-generate.nix


Python dependencies
===================

.. code:: shell

   pip2nix generate --licenses
   # or faster
   nix-shell pkgs/shell-generate.nix --command "pip2nix generate --licenses"


.. Links

.. _RhodeCode Enterprise CE: https://code.rhodecode.com/rhodecode-enterprise-ce
