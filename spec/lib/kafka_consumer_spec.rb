# spec/services/kafka_consumer_spec.rb
require 'rails_helper'

RSpec.describe KafkaConsumer do
  describe "#consume" do
    it "yields each message to the block" do
      # Setup ENV
      stub_const("ENV", ENV.to_hash.merge("KAFKA_BROKERS" => "localhost:9092"))

      # Prepare a mock message
      mock_message = double("Kafka::FetchedMessage", value: "test_message")

      # Create a fake Kafka object that yields the mock message
      fake_kafka = double("Kafka")
      allow(fake_kafka).to receive(:each_message).with(topic: "my-topic")
                                                 .and_yield(mock_message)

      # Stub Kafka.new to return the fake Kafka instance
      allow(Kafka).to receive(:new).with([ "localhost:9092" ]).and_return(fake_kafka)

      # Spy on the block call
      block = double("block")
      expect(block).to receive(:call).with(mock_message)

      # Invoke the consumer
      consumer = KafkaConsumer.new("my-topic")
      consumer.consume { |msg| block.call(msg) }
    end
  end
end
