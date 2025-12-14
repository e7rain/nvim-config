return {
  ['Refactor code'] = {
    strategy = 'chat',
    description = 'Refactoriza el código para mejorar su calidad y legibilidad.',
    opts = {
      index = 2,
      is_slash_cmd = false,
      auto_submit = true,
      short_name = 'refactor-code',
    },
    prompts = {
      {
        role = 'user',
        content = [[#{lsp}
Por favor, refactoriza #{buffer} para que sea más limpio, legible y eficiente. Asegúrate de:

- Eliminar código redundante o innecesario.
- Mejorar la organización y estructura del código.
- Usar nombres de variables y funciones descriptivos.
- Aplicar buenas prácticas del lenguaje utilizado.
- Optimizar el rendimiento donde sea posible, sin perder claridad.

Para aplicar los cambios usa @{insert_edit_into_file}, no pidas confirmación adicional.
Al final asegurate que el código resultante no tenga errores de sintaxis.
]],
      },
    },
  },
  ['Edit buffer'] = {
    strategy = 'chat',
    description = 'Editar buffer segun las indicaciones proporcionadas.',
    opts = {
      index = 1,
      is_slash_cmd = false,
      auto_submit = false,
      short_name = 'edit-buffer',
    },
    prompts = {
      {
        role = 'user',
        content = [[#{buffer}
@{full_stack_dev}
]],
      },
    },
  },
}
