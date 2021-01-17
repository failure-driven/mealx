module System
  module ServingTime
    def self.setup_times
      start_time = Time.parse("2000/01/01 00:00:00")
      end_time = start_time + 7.days
      time_index = start_time
      while time_index < end_time
        next_time_index = time_index + 60.minutes
        name = [
          time_index.strftime("%A %H:%M"),
          next_time_index.strftime("%H:%M"),
        ].join(" - ")
        puts name
        create_or_update(
          ::ServingTime,
          {
            id: Digest::UUID.uuid_v5(
              Digest::UUID::DNS_NAMESPACE,
              name,
            ),
            name: name,
            period_start_time: time_index,
            period_end_time: next_time_index,
          },
        )
        time_index = next_time_index
      end
    end

    def self.create_or_update(model_class, attributes)
      if (model = model_class.find_by(id: attributes[:id]))
        model.attributes = model.attributes.merge(attributes.without(:id))
        model.save! if model.changed?
        model
      else
        model_class.create!(attributes)
      end
    end
  end
end
