module MessageStore
  module StreamName
    Error = Class.new(RuntimeError)

    def self.id_separator
      '-'
    end

    def self.compound_id_separator
      '+'
    end

    def self.category_separator
      ':'
    end

    def self.type_separator
      '+'
    end

    def self.stream_name(category_name, id=nil, type: nil, types: nil)
      if category_name == nil
        raise Error, "Category name must not be omitted from stream name"
      end

      types = Array(types)
      types.unshift(type) unless type.nil?

      type_list = nil
      type_list = types.join(type_separator) unless types.empty?

      stream_name = category_name
      stream_name = "#{stream_name}#{category_separator}#{type_list}" unless type_list.nil?

      if not id.nil?
        if id.is_a?(Array)
          id = id.join(compound_id_separator)
        end
      end

      stream_name = "#{stream_name}#{id_separator}#{id}" unless id.nil?

      stream_name
    end

    def self.split(stream_name)
      stream_name.split(id_separator, 2)
    end

    def self.get_id(stream_name)
      split(stream_name)[1]
    end

    def self.get_ids(stream_name)
      ids = get_id(stream_name)

      return [] if ids.nil?

      ids.split(compound_id_separator)
    end

    def self.get_category(stream_name)
      split(stream_name)[0]
    end

    def self.category?(stream_name)
      !stream_name.include?(id_separator)
    end

    def self.get_category_type(stream_name)
      return nil unless stream_name.include?(category_separator)

      category = get_category(stream_name)

      category.split(category_separator)[1]
    end

    def self.get_type(*args)
      get_category_type(*args)
    end

    def self.get_category_types(stream_name)
      type_list = get_type(stream_name)

      return [] if type_list.nil?

      type_list.split(type_separator)
    end

    def self.get_types(*args)
      get_category_types(*args)
    end

    def self.get_entity_name(stream_name)
      get_category(stream_name).split(category_separator)[0]
    end
  end
end
