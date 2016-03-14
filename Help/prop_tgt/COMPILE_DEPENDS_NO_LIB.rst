COMPILE_DEPENDS_NO_LIB
----------------------

Ninja only: Whether object files skip dependencies on their target's link libraries.

When set for a target the object file targets will not specify a dependency on
the target's link libraries. This way the object files can already be built even
though the target link libraries are not yet available.

As an example consider the following snippet:

.. code-block:: cmake

    ADD_LIBRARY(mylib lib.c)

    ADD_EXECUTABLE(myexe exe.c)
    TARGET_LINK_LIBRARIES(myexe lib)

As the target ``mylib`` might specify some more outputs (e.g. via
`ADD_CUSTOM_COMMAND`), the default behaviour is to let the compilation of
``exe.c`` depend on the completion of the target ``mylib``. If the target
property `COMPILE_DEPENDS_NO_LIB` is set for ``myexe``, either through the
global default

.. code-block:: cmake

    SET(CMAKE_COMPILE_DEPENDS_NO_LIB)

or through a target specific property

.. code-block:: cmake

    SET_PROPERTY(TARGET myexe PROPERTY COMPILE_DEPENDS_NO_LIB ON)

the dependency will be omitted and ``exe.c`` can be compiled without waiting for
the successful link of ``mylib``.

.. note::
    If the compilation of your object files depends on a byproduct that is
    produced during the creation of one of the link libraries, you have to
    disable the functionality for the affected target.

This property is initialized by the value of the variable
:variable:`CMAKE_COMPILE_DEPENDS_NO_LIB` if it is set when a target is created.

