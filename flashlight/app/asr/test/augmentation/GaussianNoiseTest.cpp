/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "flashlight/app/asr/augmentation/GaussianNoise.h"
#include "flashlight/app/asr/augmentation/SoundEffectUtil.h"
#include "flashlight/fl/common/Init.h"

using namespace ::fl::app::asr::sfx;

const int numSamples = 10000;

double timeit(std::function<void()> fn) {
  // warmup
  for (int i = 0; i < 10; ++i) {
    fn();
  }
  af::sync();

  int num_iters = 100;
  af::sync();
  auto start = af::timer::start();
  for (int i = 0; i < num_iters; i++) {
    fn();
  }
  af::sync();
  return af::timer::stop(start) / num_iters;
}

TEST(GaussianNoise, SnrCheck) {
  int numTrys = 10;
  float tolerance = 1e-1;
  for (int r = 0; r < numTrys; ++r) {
    RandomNumberGenerator rng(r);
    std::vector<float> signal(numSamples);
    for (auto& i : signal) {
        i = rng.random() ;
    }

    GaussianNoise::Config cfg;
    cfg.minSnr_ = 8;
    cfg.maxSnr_ = 12;
    GaussianNoise sfx(cfg, r);
    auto originalSignal = signal;
    sfx.apply(signal);
    ASSERT_EQ(signal.size(), originalSignal.size());
    std::vector<float> noise(signal.size());
    for (int i = 0 ;i < noise.size(); ++i) {
      noise[i] = signal[i] - originalSignal[i];
    }
    ASSERT_LE(signalToNoiseRatio(originalSignal, noise), cfg.maxSnr_ + tolerance);
    ASSERT_GE(signalToNoiseRatio(originalSignal, noise), cfg.minSnr_ - tolerance);
  }
}

int main(int argc, char** argv) {
  ::testing::InitGoogleTest(&argc, argv);
  fl::init();
  return RUN_ALL_TESTS();
}
