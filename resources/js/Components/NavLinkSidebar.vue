<script setup>
import { computed } from 'vue';
import { Link } from '@inertiajs/vue3';
const props = defineProps({
    href: {
        type: String,
        required: true,
    },
    active: {
        type: Boolean,
    },
});
const classes = computed(() =>
    props.active
        ? 'group mb-3 flex items-center rounded-lg p-2 text-gray-900  bg-green-200 dark:bg-green-800 dark:text-white'
        : 'group mb-3 flex items-center rounded-lg p-2 text-gray-900  dark:text-white',
);
</script>

<template>
    <Link :href="href" :class="classes" preserve-scroll preserve-state>
        <span class="ml-3">
            <slot />
        </span>
    </Link>
</template>

<style></style>
