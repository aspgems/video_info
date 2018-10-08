require 'spec_helper'

describe VideoInfo::Providers::Tedx do
  describe 'with video https://www.ted.com/talks/mariana_atencio_what_makes_you_special' do
    subject(:video_info) { VideoInfo.new(url) }

    let(:url) { 'https://www.ted.com/talks/mariana_atencio_what_makes_you_special' }

    describe '#provider' do
      subject { super().provider }
      it { is_expected.to eq 'Tedx' }
    end

    describe '#url' do
      subject { super().url }
      it { is_expected.to eq url }
    end

    describe '#title' do
      subject { super().title }
      it { is_expected.to eq 'Mariana Atencio: What makes you special?' }
    end

    describe '#description' do
      subject { super().description }

      let(:description) do
        'When journalist Mariana Atencio was seven, her father sent her from her '\
        'home in Venezuela to a summer camp in Brainerd, Minnesota. Unsurprisingly, '\
        'she was treated like an outsider. Over the course of many more such camps '\
        'and a senior year in an American high school, she discovered that the best '\
        'way to belong was to embrace the qualities that made her different. In this '\
        'deeply personal talk, Atencio describes how these early lessons helped her '\
        'succeed as an immigrant and as a journalist.'
      end

      it { is_expected.to eq description }
    end

    describe '#duration' do
      subject { super().duration }
      it { is_expected.to eq '0' }
    end

    describe '#thumbnail_small' do
      subject { super().thumbnail_small }

      let(:thumbnail_url) do
        'https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/8733af45-0518-4c58-b451-d926d3fa08f1/MarianaAtencio.jpeg?quality=95&w=120'
      end

      it { is_expected.to eq thumbnail_url }
    end

    describe '#thumbnail_medium' do
      subject { super().thumbnail_medium }
      
      let(:thumbnail_url) do
        'https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/8733af45-0518-4c58-b451-d926d3fa08f1/MarianaAtencio.jpeg?quality=95&w=480'
      end

      it { is_expected.to eq thumbnail_url }
    end

    describe '#thumbnail_large' do
      subject { super().thumbnail_large }
      
      let(:thumbnail_url) do
        'https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/8733af45-0518-4c58-b451-d926d3fa08f1/MarianaAtencio.jpeg'
      end

      it { is_expected.to eq thumbnail_url }
    end

    describe '#thumbnail' do
      subject { super().thumbnail }
      
      let(:thumbnail_url) do
        'https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/8733af45-0518-4c58-b451-d926d3fa08f1/MarianaAtencio.jpeg'
      end

      it { is_expected.to eq thumbnail_url }
    end

    describe '#author_thumbnail' do
      subject { super().author_thumbnail }

      let(:thumbnail_url) { '' }

      it { is_expected.to eq thumbnail_url }
    end

    describe '#author' do
      subject { super().author }
      it { is_expected.to eq 'Mariana Atencio' }
    end

    describe '#author_url' do
      subject { super().author_url }
      it { is_expected.to eq 'https://www.ted.com/talks/mariana_atencio_what_makes_you_special' }
    end
  end
end
