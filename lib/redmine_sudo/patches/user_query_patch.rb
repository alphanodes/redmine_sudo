# frozen_string_literal: true

module RedmineSudo
  module Patches
    module UserQueryPatch
      extend ActiveSupport::Concern

      included do
        include Additionals::Concerns::Query
        prepend InstanceOverwriteMethods
      end

      module InstanceOverwriteMethods
        def default_columns_names
          columns_names = super
          columns_names.map { |c| c == :admin ? User.admin_column_field.to_sym : c }
        end

        def initialize_available_filters
          super

          # remove existing admin filter
          available_filters.reject! { |filter| filter == 'admin' }

          add_available_filter User.admin_column_field,
                               type: :list,
                               label: :field_admin,
                               values: bool_values
        end

        def available_columns
          if @available_columns.blank?
            @available_columns = super

            # remove admin column, which we want to overwrite it
            @available_columns.reject! { |column| column.name == :admin }

            admin_field = User.admin_column_field
            @available_columns << QueryColumn.new(admin_field.to_sym,
                                                  sortable: "#{User.table_name}.#{admin_field}",
                                                  default_order: 'desc',
                                                  groupable: true,
                                                  caption: :field_admin)
          end
          @available_columns
        end
      end
    end
  end
end
