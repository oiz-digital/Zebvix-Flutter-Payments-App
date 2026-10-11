import React, { useEffect } from 'react';
import { Image, StyleSheet, View, useWindowDimensions } from 'react-native';
import { StatusBar } from 'expo-status-bar';
import { LinearGradient } from 'expo-linear-gradient';
import Animated, {
  Easing,
  interpolate,
  useAnimatedStyle,
  useSharedValue,
  withRepeat,
  withSequence,
  withTiming,
} from 'react-native-reanimated';
import { useColors } from '@/hooks/useColors';

const splashArtwork = require('../assets/images/zebvix-splash.png');

export default function SplashScreen() {
  const { width, height } = useWindowDimensions();
  const colors = useColors();
  const entrance = useSharedValue(0);
  const sweep = useSharedValue(-width * 1.4);
  const pulse = useSharedValue(0);

  useEffect(() => {
    entrance.value = withTiming(1, {
      duration: 1150,
      easing: Easing.out(Easing.cubic),
    });
    sweep.value = withRepeat(
      withTiming(width * 1.9, {
        duration: 4400,
        easing: Easing.inOut(Easing.quad),
      }),
      -1,
      false,
    );
    pulse.value = withRepeat(
      withSequence(
        withTiming(1, { duration: 1900, easing: Easing.inOut(Easing.sin) }),
        withTiming(0, { duration: 1900, easing: Easing.inOut(Easing.sin) }),
      ),
      -1,
      false,
    );
  }, [entrance, pulse, sweep, width]);

  const entranceStyle = useAnimatedStyle(() => ({
    opacity: entrance.value,
    transform: [{ scale: interpolate(entrance.value, [0, 1], [1.035, 1]) }],
  }));

  const shimmerStyle = useAnimatedStyle(() => ({
    transform: [{ translateX: sweep.value }, { rotate: '-22deg' }],
  }));

  const haloStyle = useAnimatedStyle(() => ({
    opacity: interpolate(pulse.value, [0, 1], [0.12, 0.38]),
    transform: [{ scale: interpolate(pulse.value, [0, 1], [0.84, 1.12]) }],
  }));

  return (
    <View style={[styles.screen, { backgroundColor: colors.background }]}>
      <StatusBar hidden />
      <Animated.View style={[StyleSheet.absoluteFill, entranceStyle]}>
        <Image
          source={splashArtwork}
          style={StyleSheet.absoluteFill}
          resizeMode="stretch"
          accessible
          accessibilityLabel="Zebvix — recharge, bills and payments"
        />
      </Animated.View>

      <Animated.View
        pointerEvents="none"
        style={[
          styles.halo,
          {
            top: height * 0.16,
            left: width * 0.28,
            width: width * 0.44,
            height: width * 0.44,
            backgroundColor: colors.primary,
            shadowColor: colors.primary,
          },
          haloStyle,
        ]}
      />

      <Animated.View
        pointerEvents="none"
        style={[
          styles.shimmer,
          {
            width: width * 0.58,
            height: height * 1.45,
            top: -height * 0.18,
            left: -width * 0.4,
          },
          shimmerStyle,
        ]}
      >
        <LinearGradient
          colors={[
            'rgba(255,255,255,0)',
            'rgba(255,255,255,0.08)',
            'rgba(255,255,255,0.58)',
            'rgba(203,255,225,0.22)',
            'rgba(255,255,255,0)',
          ]}
          start={{ x: 0, y: 0.5 }}
          end={{ x: 1, y: 0.5 }}
          style={StyleSheet.absoluteFill}
        />
      </Animated.View>
    </View>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    overflow: 'hidden',
  },
  halo: {
    position: 'absolute',
    borderRadius: 999,
    shadowOpacity: 0.28,
    shadowRadius: 38,
    elevation: 12,
  },
  shimmer: {
    position: 'absolute',
  },
});
