class MigrateToPasswordDigest < ActiveRecord::Migration
      def up
            # si esta migración se ejecuta inmediatamente después de la anterior
            # que realiza cambios en la tabla `users`, el modelo ActiveRecord
            # podría no estar actualizado a la última información de columnas de la tabla.
            # Esto nos asegura que estará listo para poder utilizar la nueva información.
            User.reset_column_information
            User.find_each do |user|
                  # el método password y password= ahora fueron creados por has_secure_password.
                  # Así que si queremos obtener el valor de la columna password de la base de datos
                  # necesitamos hacerlo de manera directa, no a través de los métodos que solemos utilizar.
                  user.password = user.attributes['password']
                  user.save
            end
      end

      def down
            raise ActiveRecord::IrreversibleMigration.new
      end
end
