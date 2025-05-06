require 'rails_helper'

RSpec.describe KafkaProducer do
  describe ".publish" do
    it "publishes a message using kafka.deliver_message" do
      stub_const("ENV", ENV.to_hash.merge("KAFKA_BROKERS" => "localhost:9092"))

      fake_kafka = double("Kafka")

      allow(Kafka).to receive(:new).with([ "localhost:9092" ]).and_return(fake_kafka)
      expect(fake_kafka).to receive(:deliver_message).with("hello world", topic: "my-topic")

      KafkaProducer.publish("my-topic", "hello world")
    end
  end
end
